extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var settings_button = $SubMenu/MenuBackground/MarginContainer/MainMenuContainer/Settings
	settings_button.disabled = true
	settings_button.set_pressed_no_signal(true)
