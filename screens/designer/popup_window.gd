extends Window

signal submitted

var stored_option: String = ""
var stored_text: String = ""

@onready var input_field: TextEdit = $VBoxContainer/input
@onready var option_field: OptionButton = $VBoxContainer/option
@onready var ok_button: Button = $VBoxContainer/Button

func _ready():
	pass
	#btnOk.pressed.connect(_on_ok_pressed)

func open_popup():
	popup_centered()
	input_field.text = ""
	input_field.grab_focus()

func _on_btn_ok_pressed():
	stored_option = option_field.text
	stored_text = input_field.text
	emit_signal("submitted")
	hide()
