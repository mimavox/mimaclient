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

# Save the graph - TODO: Implement name
func _on_btn_save_pressed() -> void:
	var ge_nodes = graph.get_all_graph_nodes()
	var ge_edges = graph.get_connection_list()
	var nx_json = globals.graphedit_to_networkx(ge_nodes, ge_edges)
	
	var post_body = nx_json
	var post_headers = ["Content-Type: application/json"]
	var url = globals.apiurl + "/save/name"
	
	# MUST BE AUTHORIZED!!

	$HTTPRequest.request_completed.connect(_on_request_completed)
	var my_result = $HTTPRequest.request(url, post_headers, HTTPClient.METHOD_POST, post_body)
	
	if my_result != OK:
		push_error("An error occurred in the HTTP request.")
	else:
		print(my_result)


func _on_request_completed(result, response_code, headers, body):
	print("RESULT: ", result)
	print("RESPONSE_CODE: ", response_code)
	print("HEADERS: ", headers)
	print("BODY: ", body)
	#var my_result = JSON.parse_string(body.get_string_from_utf8())
	#print(json["name"])
	#print(my_result)
	 
