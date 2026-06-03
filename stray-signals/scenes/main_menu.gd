extends Button


func _on_new_game_pressed() -> void:
	GameState.new_game()
	get_tree().current_scene.get_node("MainMenu").visible = false


func _on_load_game_pressed() -> void:
	GameState.load_game()
	get_tree().current_scene.get_node("MainMenu").visible = false


func _on_settings_pressed() -> void:
	get_tree().current_scene.get_node("MainMenu").visible = false
	get_tree().current_scene.get_node("Settings").visible = true
