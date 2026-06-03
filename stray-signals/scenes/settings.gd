extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var settings_button = $SubMenu/MenuBackground/MarginContainer/MainMenuContainer/Settings
	settings_button.disabled = true
	settings_button.set_pressed_no_signal(true)
	
	var music_bus_index: int = AudioServer.get_bus_index("music")
	var sfx_bus_index: int = AudioServer.get_bus_index("One-Shot SFX")

	var music_slider = $SettingsBackground/MarginContainer/ContentArea/VBoxContainer/MusicVolume/HBoxContainer/MusicSlider
	var sfx_slider = $SettingsBackground/MarginContainer/ContentArea/VBoxContainer/SFXVolume/HBoxContainer/SFXSlider
	var text_slider = $SettingsBackground/MarginContainer/ContentArea/VBoxContainer2/TextSpeed/HBoxContainer/TextSpeedSlider
	
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	text_slider.value = Dialogic.Settings.get_setting("text_speed", 1)
	
	music_slider.value_changed.connect(_on_music_slider_changed, music_bus_index)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed, sfx_bus_index)
	text_slider.value_changed.connect(_on_text_speed_slider_changed)


func _on_music_slider_changed(new_speed, music_bus_index) -> void:
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(new_speed))
	AudioServer.set_bus_mute(music_bus_index, new_speed < 0.01)


func _on_sfx_slider_changed(new_speed, sfx_bus_index) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(new_speed))
	AudioServer.set_bus_mute(sfx_bus_index, new_speed < 0.01)


func _on_text_speed_slider_changed(new_speed) -> void:
	Dialogic.Settings.text_speed = new_speed
