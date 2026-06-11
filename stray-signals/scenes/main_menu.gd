extends Button


func _on_new_game_pressed() -> void:
	GameState.new_game()
	get_tree().current_scene.get_node("MainMenu").visible = false


func _on_load_game_pressed() -> void:
	GameState.load_game()
	get_tree().current_scene.get_node("MainMenu").visible = false


func _on_settings_pressed() -> void:
	GameState.settings_return_target = "main_menu"
	get_tree().current_scene.get_node("MainMenu").visible = false
	get_tree().current_scene.get_node("Settings").visible = true


func _on_credits_pressed() -> void:
	get_tree().current_scene.get_node("MainMenu").visible = false
	get_tree().current_scene.get_node("Credits").visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()
