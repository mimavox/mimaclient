'''
"Maze Runner" (https://skfb.ly/DqJI) by BinayakGhosh is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).
'''

extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var apiurl = "http://localhost"
	print(apiurl)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_back_button_down() -> void:
	get_tree().change_scene_to_file("res://screens/main/main.tscn")


func _on_btn_snapshot_button_down() -> void:
	print(settings.test)
	var subviewport = $simulation/SubViewport
	var texture = subviewport.get_texture()

	if texture:
		var image = texture.get_image()
		var path = "res://snapshot.png"  # You can change the name/path
		var err = image.save_png(path)
		if err == OK:
			print("Snapshot saved to: ", path)
		else:
			push_error("Failed to save snapshot: %s" % err)
	else:
		push_error("SubViewport texture not available!")
