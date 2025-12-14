extends Control

# Marks the GraphEdit node for easy reference later on:
@onready var graph = %GraphEdit



func _ready():
	graph.connection_request.connect(_on_graph_connection_request)
	graph.disconnection_request.connect(_on_graph_disconnection_request)

# Nav buttons ----------------------------------------------
func _on_btn_runner_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/runner/runner.tscn")

func _on_btn_home_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main.tscn")
# --------------------------------------------------------



func get_all_graph_nodes():
	var graph_nodes = []
	# get_children() returns an array of all direct child nodes
	for child in graph.get_children():
		# Check if the child is a GraphNode
		if child is GraphNode:
			graph_nodes.append(child.title)
	return graph_nodes

# UI buttons ----------------------------------------------

# Clear the graph
func _on_btn_clear_pressed() -> void:
	pass

# Load a graph
func _on_btn_load_pressed() -> void:
	pass

# Save the graph
func _on_btn_save_pressed() -> void:
	var ge_nodes = get_all_graph_nodes()
	var ge_edges = graph.get_connection_list()	
	var nx_nodes = globals.graphedit_to_networkx(JSON.stringify(ge_nodes), JSON.stringify(ge_edges))

func _make_unique_name(base: String) -> String:
	var name = base
	var i = 1
	while graph.has_node(name):
		name = "%s_%d" % [base, i]
		i += 1
	return name

# Add a module
func _on_btn_add_pressed() -> void:
	var popup = $Background/VBoxContainer/footer/PopupWindow
	popup.open_popup()

	await popup.submitted  # Pause execution until the popup is closed.

	var option = popup.stored_option
	var description = popup.stored_text
	var type_in = popup.type_in
	var type_out = popup.type_out

	print("Creating new GraphNode named:", option)

	# Create the new GraphNode
	var gnode := GraphNode.new()
	gnode.title = option       # Set title (what the user sees)
	gnode.name = _make_unique_name(option)

	# Assign a script to the GraphNode
	var graph_node_script = load("res://screens/designer/graph_node.gd")  # Replace with the correct path
	gnode.set_script(graph_node_script)

	# Configure port types in the node script
	gnode.input_port_types = [type_in]    # Add input port type
	gnode.output_port_types = [type_out]  # Add output port type

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

	graph.connect_node(from_node, from_port, to_node, to_port)
	print("Connected %s:%s to %s:%s" % [from_node, from_port, to_node, to_port])

func _on_graph_disconnection_request(
	from_node: StringName,
	from_port: int,
	to_node: StringName,
	to_port: int
) -> void:
	graph.disconnect_node(from_node, from_port, to_node, to_port)
	print("Disconnected %s:%s from %s:%s" % [from_node, from_port, to_node, to_port])
