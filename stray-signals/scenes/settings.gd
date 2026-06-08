extends Control


func _ready() -> void:
	var settings_button = $SubMenu/MenuBackground/MarginContainer/MainMenuContainer/Settings
	settings_button.disabled = true
	settings_button.set_pressed_no_signal(true)
	
	var music_bus_index: int = AudioServer.get_bus_index("music")
	var sfx_bus_index: int = AudioServer.get_bus_index("One-Shot SFX")
	
	print("indexs ", music_bus_index, sfx_bus_index)

	var music_slider = $SettingsBackground/MarginContainer/ContentArea/VBoxContainer/MusicVolume/HBoxContainer/MusicSlider
	var sfx_slider = $SettingsBackground/MarginContainer/ContentArea/VBoxContainer/SFXVolume/HBoxContainer/SFXSlider
	var text_slider = $SettingsBackground/MarginContainer/ContentArea/VBoxContainer2/TextSpeed/HBoxContainer/TextSpeedSlider
	
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	text_slider.value = Dialogic.Settings.get_setting("text_speed", 1)
	
	music_slider.value_changed.connect(_on_music_slider_changed.bind(music_bus_index))
	sfx_slider.value_changed.connect(_on_sfx_slider_changed.bind(sfx_bus_index))
	text_slider.value_changed.connect(_on_text_speed_slider_changed)
	
	# find Dialogic's hidden layout style for internal audio (typing sounds)
	Dialogic.timeline_started.connect(_on_dialogic_timeline_started)


func _on_music_slider_changed(new_speed, music_bus_index) -> void:
	if new_speed <= 0.001:
		AudioServer.set_bus_mute(music_bus_index, true)
		print("MUSIC MUTED")
	else:
		var db = linear_to_db(new_speed)
		AudioServer.set_bus_volume_db(music_bus_index, db)
		AudioServer.set_bus_mute(music_bus_index, false)
		print("SFX Bus Volume changed to: ", db, " dB (Linear: ", new_speed, ")")


func _on_sfx_slider_changed(new_speed, sfx_bus_index) -> void:
	if new_speed <= 0.001:
		AudioServer.set_bus_mute(sfx_bus_index, true)
		print("SFX MUTED")
	else:
		var db = linear_to_db(new_speed)
		AudioServer.set_bus_volume_db(sfx_bus_index, db)
		AudioServer.set_bus_mute(sfx_bus_index, false)
		print("SFX Bus Volume changed to: ", db, " dB (Linear: ", new_speed, ")")


func _on_dialogic_timeline_started() -> void:
	await get_tree().process_frame
	
	var current_layout = Dialogic.Styles.get_layout_node()
	if current_layout:
		var type_sounds_node = current_layout.find_child("*TypeSounds*", true, false)
		
		if type_sounds_node and "bus" in type_sounds_node:
			type_sounds_node.bus = "One-Shot SFX"


func _on_text_speed_slider_changed(new_speed: float) -> void:
	Dialogic.Settings.text_speed = 2.0 - new_speed
