extends Control

@onready var graph = %GraphEdit

func _ready():
	pass

func _on_btn_runner_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/runner/runner.tscn")

func _on_btn_home_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main.tscn")

# Clear the graph
func _on_btn_clear_pressed() -> void:
	pass

# Load a graph
func _on_btn_load_pressed() -> void:
	pass

# Save the graph
func _on_btn_save_pressed() -> void:
	var ge_nodes = graph.get_all_graph_nodes()
	var ge_edges = graph.get_connection_list()
	var nx_nodes = globals.graphedit_to_networkx(ge_nodes, ge_edges)
