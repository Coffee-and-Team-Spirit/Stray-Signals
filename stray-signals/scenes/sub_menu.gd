extends Control


func _on_back_pressed() -> void:
	var game_root = get_tree().current_scene
	
	get_tree().current_scene.get_node("Settings").visible = false
	get_tree().current_scene.get_node("MainMenu").visible = true


func _on_load_game_pressed() -> void:
	GameState.load_game()
	#get_tree().change_scene_to_file("res://scenes/main.tscn")
	print("Load game - settings")
	# Hide menu
	get_tree().current_scene.get_node("Settings").visible = false
