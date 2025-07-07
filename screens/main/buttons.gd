extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(settings.baseurl)
	settings.init()
	print(settings.baseurl)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_2d_button_down() -> void:
	get_tree().change_scene_to_file("res://screens/mima2D/mima2D.tscn")


func _on_btn_3d_button_down() -> void:
	get_tree().change_scene_to_file("res://screens/mima3D/mima3D.tscn")


func _on_btn_test_button_down() -> void:
	get_tree().change_scene_to_file("res://screens/testdev/testdev.tscn")
