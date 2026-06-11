extends Control


func _ready() -> void:
	
	var credits_button = $SubMenu/SubMenu/MarginContainer/MainMenuContainer/Credits
	credits_button.disabled = true
	credits_button.set_pressed_no_signal(true)
