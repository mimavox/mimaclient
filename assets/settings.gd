extends Node

var baseurl = ""
var apiurl = ""

func init():
	baseurl = "http://localhost"
	apiurl = ""	

func _input(event):
	
	if event.is_action_pressed("exit"):
		get_tree().quit()
