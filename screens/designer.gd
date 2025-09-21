extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main.tscn")


func _on_btn_runner_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/runner.tscn")
