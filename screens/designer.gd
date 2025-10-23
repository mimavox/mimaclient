extends Control

# Marks the GraphEdit node for easy reference later on:
@onready var graph = %GraphEdit

func _on_btn_runner_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/runner.tscn")

func _on_btn_home_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main.tscn")

func _on_button_pressed() -> void:
	var node := GraphNode.new()
	
	node.title = "New node"
	node.name = "New node"
	
	node.position_offset = Vector2(100, 150)
	# node.position_offset.x = get_viewport().get_mouse_position().x
	
	# You can set the custom minimum size if you don't want it to resize automatically
	node.custom_minimum_size = Vector2(200, 100)
	
	var slots = Control.new()
	node.add_child(slots)
	node.set_slot_enabled_left(0, true)
	node.set_slot_enabled_right(0, true)

	graph.add_child(node)



func _on_graph_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	graph.connect_node(from_node, from_port, to_node, to_port)


func _on_graph_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	graph.disconnect_node(from_node, from_port, to_node, to_port)


func _on_button_2_pressed() -> void:
	var result = graph.get_connection_list()
	print(JSON.stringify(result))
	
