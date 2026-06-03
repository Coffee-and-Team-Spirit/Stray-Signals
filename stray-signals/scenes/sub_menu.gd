extends Control


func _on_back_pressed() -> void:
	get_tree().current_scene.get_node("SettingsOverlay").visible = false
	get_tree().current_scene.get_node("Settings").visible = false
	get_tree().current_scene.get_node("Credits").visible = false
	
	if GameState.settings_return_target == "pause_menu":
		# Return to Dialogic
		get_tree().paused = false
		
		var game_root = get_tree().root.get_node("GameRoot")
		
		# Show HUD again
		var hud = game_root.get_node_or_null("HUD")
		if hud:
			hud.visible = true
			
		# Resume dialogic if needed
		if Dialogic.paused:
			Dialogic.paused = false
			
	else:
		# Return to main menu
		get_tree().current_scene.get_node("MainMenu").visible = true


func _on_load_game_pressed() -> void:
	GameState.load_game()
	get_tree().current_scene.get_node("Settings").visible = false
	get_tree().current_scene.get_node("Credits").visible = false


func _on_new_game_pressed() -> void:
	GameState.new_game()
	get_tree().current_scene.get_node("Settings").visible = false
	get_tree().current_scene.get_node("Credits").visible = false


func _on_settings_pressed() -> void:
	get_tree().current_scene.get_node("Settings").visible = true
	get_tree().current_scene.get_node("Credits").visible = false


func _on_credits_pressed() -> void:
	get_tree().current_scene.get_node("Settings").visible = false
	get_tree().current_scene.get_node("Credits").visible = true
