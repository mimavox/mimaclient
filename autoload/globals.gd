extends Node

var apiurl = ""
var logged_in = ""

func init():
	apiurl = "http://127.0.0.1:8000"
	logged_in = false

func exist_disconnected_nodes(node_list, edge_list):
	for node in node_list:
		if node not in edge_list:
			print("NODE: ", node)
			print("EDGES: ", edge_list)
			return true
	return false

func graphedit_to_networkx(nodes: Array, edges: Array) -> String:
	var node_list = []
	var edge_list = []
	
	for node in nodes:
		var node_dict = {}
		
		node_dict['type'] = node[0]
		node_dict['id'] = node[1].split("@")[-1]
		node_list.append(node_dict)
	
	for edge in edges:
		var edge_dict = {}
		var source = edge["from_node"].split("@")[-1]
		var target = edge["to_node"].split("@")[-1]
		edge_dict["source"] = source
		edge_dict["target"] = target
		edge_list.append(edge_dict)
	
	var graph_dict = {}
	graph_dict["directed"] = true
	graph_dict["multigraph"] = false
	graph_dict["nodes"] = node_list
	graph_dict["edges"] = edge_list
	
	var graph_json = JSON.stringify(graph_dict)
	print(graph_json)
	
	return graph_json

# TODO
func networkx_to_graphedit(nx_json) -> String:
	# Used when loading saved graph from server. Here, the graph must be constructed from scratch, based on the unique ids represented in the transfer format (json).
	
	var myjson = "ntog"
	return JSON.stringify(myjson)
