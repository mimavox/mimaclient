extends GraphEdit

@onready var graph = %GraphEdit
@onready var popup = %PopupWindow

func _ready() -> void:
	connection_request.connect(_on_graph_connection_request)
	disconnection_request.connect(_on_graph_disconnection_request)

func _make_unique_name(base: String) -> String:
	var name = base
	var i = 1
	while graph.has_node(name):
		name = "%s_%d" % [base, i]
		i += 1
	return name

func get_all_graph_nodes():
	var graph_nodes = []
	for child in graph.get_children():
		if child is GraphNode:
			graph_nodes.append(child.name)
	return graph_nodes

# Add a node
func _on_btn_add_pressed() -> void:
	popup.open_popup()

	await popup.submitted  # Pause execution until the popup is closed.

	var option = popup.stored_option
	var description = popup.stored_text
	var type_in = popup.type_in
	var type_out = popup.type_out
	
	# Create the new GraphNode
	var gnode := GraphNode.new()
	gnode.ignore_invalid_connection_type = true	
	gnode.title = option
	gnode.name = _make_unique_name(option)

	# Customize the visual appearance of the node
	gnode.position_offset = Vector2(100, 150)
	gnode.custom_minimum_size = Vector2(200, 50)

	var vbox := VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_FILL
	vbox.size_flags_vertical = Control.SIZE_EXPAND
	vbox.custom_minimum_size = Vector2(200, 0)  # Fix wrap width
	gnode.add_child(vbox)

	var lnode := Label.new()
	lnode.text = description
	lnode.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	lnode.size_flags_vertical = Control.SIZE_EXPAND | Control.SIZE_SHRINK_CENTER
	vbox.add_child(lnode)
	
	# Configure the GraphNode ports
	gnode.set_slot(
		0,
		true, type_in, Color.WHITE,  # LEFT PORT (Input) Configuration
		true, type_out, Color.RED    # RIGHT PORT (Output) Configuration
	)

	# Add the GraphNode to the GraphEdit
	graph.add_child(gnode)

# Called when a node tries to connect to another node
func _on_graph_connection_request(
	from_node: StringName,
	from_port: int,
	to_node: StringName,
	to_port: int
) -> void:
	# Optional: enforce only one outgoing connection per port
	for conn in graph.get_connection_list():
		if conn.from_node == from_node and conn.from_port == from_port:
			graph.disconnect_node(conn.from_node, conn.from_port, conn.to_node, conn.to_port)
			break
	
	
	var source_node = get_node(str(from_node))
	var target_node = get_node(str(to_node))

	if source_node.get_slot_type_right(from_port) == target_node.get_slot_type_left(from_port):
		graph.connect_node(from_node, from_port, to_node, to_port)
		# print("Connected %s:%s to %s:%s" % [from_node, from_port, to_node, to_port])

# Called when a node tries to disconnect from another node
func _on_graph_disconnection_request(
	from_node: StringName,
	from_port: int,
	to_node: StringName,
	to_port: int
) -> void:
	graph.disconnect_node(from_node, from_port, to_node, to_port)
	# print("Disconnected %s:%s from %s:%s" % [from_node, from_port, to_node, to_port])
