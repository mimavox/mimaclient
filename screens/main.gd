extends Control

func _on_btn_designer_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/designer.tscn")

func _on_btn_runner_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/runner.tscn")
