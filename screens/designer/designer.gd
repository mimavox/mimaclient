extends Control

# Marks the GraphEdit node for easy reference later on:
@onready var graph = %GraphEdit

func _on_btn_runner_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/runner/runner.tscn")

func _on_btn_home_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main.tscn")

func _on_graph_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	graph.connect_node(from_node, from_port, to_node, to_port)


func _on_graph_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	graph.disconnect_node(from_node, from_port, to_node, to_port)


func get_all_graph_nodes():
	var graph_nodes = []
	# get_children() returns an array of all direct child nodes
	for child in graph.get_children():
		# Check if the child is a GraphNode
		if child is GraphNode:
			graph_nodes.append(child.name)
	return graph_nodes


func _on_new_btn_pressed() -> void:
	
	var popup = $Background/VBoxContainer/footer/PopupWindow
	popup.open_popup()

	await popup.submitted   # Execution pauses here until OK is pressed.

	var option = popup.stored_option
	var description = popup.stored_text
	print("Creating new GraphNode named:", option)
	
	var gnode := GraphNode.new()
	gnode.title = option
	gnode.name = option
	gnode.position_offset = Vector2(100, 150)
	gnode.custom_minimum_size = Vector2(200, 50)

	# Container to control width and force vertical expansion
	var vbox := VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_FILL
	vbox.size_flags_vertical = Control.SIZE_EXPAND
	vbox.custom_minimum_size = Vector2(200, 0) # important: fixes wrap width
	gnode.add_child(vbox)

	# Label that will wrap inside the container
	var lnode := Label.new()
	lnode.text = description
	lnode.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	#lnode.autowrap = true
	lnode.size_flags_vertical = Control.SIZE_EXPAND | Control.SIZE_SHRINK_CENTER
	vbox.add_child(lnode)

	# Slots etc…
	gnode.set_slot_enabled_left(0, true)
	gnode.set_slot_enabled_right(0, true)

	graph.add_child(gnode)



func _on_print_btn_pressed() -> void:
	# List:
	var nodes = get_all_graph_nodes()
	print(JSON.stringify(nodes))
	print(globals.graphedit_to_networkx("graph"))
	print(globals.networkx_to_graphedit("net"))
	
	var edges = graph.get_connection_list()
	print(JSON.stringify(edges))
