extends Control

func _on_btn_home_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main.tscn")


func _on_btn_designer_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/designer/designer.tscn")
