extends Node

var baseurl = ""
var apiurl = ""

func init():
	baseurl = "http://localhost:8001"
	apiurl = ""

func graphedit_to_networkx(nodes_json, edges_json) -> String:
	print(nodes_json)
	print(edges_json)
	var myjson = "gton"
	return JSON.stringify(myjson)

func networkx_to_graphedit(nx_json) -> String:
	print(nx_json)
	var myjson = "ntog"
	return JSON.stringify(myjson)
