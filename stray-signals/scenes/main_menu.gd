extends Button

func _on_new_game_pressed() -> void:
	var bgm = get_tree().current_scene.get_node("MainMenu/BGM")
	var tween := create_tween()
	tween.tween_property(bgm, "volume_db", -40, 2.0)
	await tween.finished
	bgm.stop()
	
	GameState.new_game()
	get_tree().current_scene.get_node("MainMenu").visible = false


func _on_load_game_pressed() -> void:
	var bgm = get_tree().current_scene.get_node("MainMenu/BGM")
	var tween := create_tween()
	tween.tween_property(bgm, "volume_db", -40, 2.0)
	await tween.finished
	bgm.stop()
	
	GameState.load_game()
	get_tree().current_scene.get_node("MainMenu").visible = false


func _on_settings_pressed() -> void:
	GameState.settings_return_target = "main_menu"
	get_tree().current_scene.get_node("MainMenu").visible = false
	var settings = get_tree().current_scene.get_node("Settings")
	settings.visible = true
	settings.get_node("SubMenu/SubMenu/MarginContainer/MainMenuContainer/Settings").disabled = true
	


func _on_credits_pressed() -> void:
	get_tree().current_scene.get_node("MainMenu").visible = false
	var credits = get_tree().current_scene.get_node("Credits")
	credits.visible = true
	credits.get_node("SubMenu/SubMenu/MarginContainer/MainMenuContainer/Credits").disabled = true


func _on_quit_pressed() -> void:
	get_tree().quit()
