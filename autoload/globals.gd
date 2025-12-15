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

func graphedit_to_networkx(nodes, edges) -> String:
	
	var cog_graph = []
	
	for element in edges:
		cog_graph.append(element["from_node"])
		cog_graph.append(element["to_node"])
	
		print(exist_disconnected_nodes(nodes, cog_graph))

	print("Node list: ", nodes)
	
	print("Connections: ", cog_graph)
	
	
	var myjson = "gton"
	return JSON.stringify(myjson)

func networkx_to_graphedit(nx_json) -> String:
	print(nx_json)
	var myjson = "ntog"
	return JSON.stringify(myjson)
