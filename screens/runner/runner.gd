extends Control

func _on_btn_home_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main.tscn")


func _on_btn_designer_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/designer/designer.tscn")


func _on_btn_1_pressed() -> void:
	var subviewport = $Simulation/CharacterBody3D/POV
	var texture = subviewport.get_texture()
	
	if texture:
		var image = texture.get_image()
		var path = "res://snapshot.png"
		var err = image.save_png(path)
		if err == OK:
			print("Snapshot saved to: ", path)
		else:
			push_error("Failed to save snapshot: %s" % err)
	else:
		push_error("Subviewport texture not available!")
	
