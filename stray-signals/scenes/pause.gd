extends Control


func _on_save_game_pressed() -> void:
	var extra_gamestate_data = {
		"drink_result": GameState.drink_result,
		"drink_hint": GameState.drink_hint,
		"target_drink": GameState.target_drink,
		"day": DayManager.day,
		"encounter": DayManager.encounter
	}
	
	Dialogic.Save.save("autosave", false, Dialogic.Save.ThumbnailMode.NONE, extra_gamestate_data)


func _on_load_game_pressed() -> void:
	GameState.load_game()


func _on_main_menu_pressed() -> void:
	get_tree().current_scene.get_node("PauseOverlay").close_everything()
	
	var game_root = get_tree().current_scene  # This is GameRoot
	
	# Remove gameplay scene
	var main = game_root.get_node_or_null("Main")
	if main:
		main.queue_free()
		
	# Show main menu
	var menu = game_root.get_node_or_null("MainMenu")
	if menu:
		menu.visible = true
		
	# Hide HUD
	var hud = game_root.get_node_or_null("HUD")
	if hud:
		hud.visible = false

	# Hide pause
	visible = false


func _on_settings_pressed() -> void:
	get_tree().current_scene.get_node("PauseOverlay").open_settings_from_pause()


func _on_back_pressed() -> void:
	get_tree().current_scene.get_node("PauseOverlay").close_pause_menu()
