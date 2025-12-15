extends Node

var baseurl = ""
var apiurl = ""

func init():
	baseurl = "http://localhost:8001"
	apiurl = ""

func graphedit_to_networkx(nodes, edges) -> String:
	
	print(edges)
	
	for element in edges:
		print(element["from_node"])
		print(element["to_node"])
	var myjson = "gton"
	return JSON.stringify(myjson)

func networkx_to_graphedit(nx_json) -> String:
	print(nx_json)
	var myjson = "ntog"
	return JSON.stringify(myjson)
