extends Button


func _on_new_game_pressed() -> void:
	GameState.drink_result = "none"
	GameState.drink_hint = "none"
	GameState.target_drink = {}
	GameState.current_character = "none"
	GameState.current_portrait_info = "none"
	
	DayManager.day = 1
	DayManager.encounter = 1
	
	if Dialogic.Save.has_slot("autosave"):
		Dialogic.Save.delete_slot("autosave")
		
	# Hide menu
	get_tree().current_scene.get_node("MainMenu").visible = false
		
	# Instance gameplay scene
	var main_scene = preload("res://scenes/main.tscn").instantiate()
	get_tree().current_scene.add_child(main_scene)
		
	# Show HUD
	get_tree().current_scene.get_node("HUD").visible = true
	
	# Start first timeline
	var first_timeline = DayManager.get_current_timeline()
	Dialogic.start("res://timelines/%s.dtl" % first_timeline)


func _on_load_game_pressed() -> void:
	GameState.load_game()
	
	print("Load game - main menu")
	
	# Hide menu
	get_tree().current_scene.get_node("MainMenu").visible = false


func _on_settings_pressed() -> void:
	# Hide menu
	get_tree().current_scene.get_node("MainMenu").visible = false
		
	# Instance gameplay scene
	var settings_scene = preload("res://scenes/settings.tscn").instantiate()
	get_tree().current_scene.add_child(settings_scene)
