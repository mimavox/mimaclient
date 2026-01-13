extends Node

var baseurl = ""
var apiurl = ""

func init():
	baseurl = "http://localhost:8001"
	apiurl = ""

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
		node_dict['id'] = node
		node_list.append(node_dict)
	
	for edge in edges:
		var edge_dict = {}
		var source = edge["from_node"]
		var target = edge["to_node"]
		edge_dict["source"] = source
		edge_dict["target"] = target
		edge_list.append(edge_dict)
	
	var graph_dict = {}
	graph_dict["directed"] = true
	graph_dict["multigraph"] = false
	graph_dict["graph"] = {}
	graph_dict["nodes"] = node_list
	graph_dict["edges"] = edge_list
	
	var graph_json = JSON.stringify(graph_dict)
	print(graph_json)
	
	return graph_json

func networkx_to_graphedit(nx_json) -> String:
	print(nx_json)
	var myjson = "ntog"
	return JSON.stringify(myjson)
