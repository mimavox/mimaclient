extends Node

var baseurl = ""
var apiurl = ""

func init():
	baseurl = "http://localhost:8001"
	apiurl = ""	

func _input(event):
	
	if event.is_action_pressed("exit"):
		get_tree().quit()
