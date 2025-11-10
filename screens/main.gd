extends Control

func _ready() -> void:
	globals.init()

func _on_btn_designer_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/designer/designer.tscn")

func _on_btn_runner_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/runner/runner.tscn")
