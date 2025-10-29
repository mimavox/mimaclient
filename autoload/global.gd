extends Node

func graphedit_to_networkx(ge_json) -> String:
	print(ge_json)
	var myjson = "gton"
	return JSON.stringify(myjson)

func networkx_to_graphedit(nx_json) -> String:
	print(nx_json)
	var myjson = "ntog"
	return JSON.stringify(myjson)
