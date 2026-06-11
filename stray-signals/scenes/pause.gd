extends Control

func get_confirmation_box():
	var overlay = get_tree().get_root().find_child("PauseOverlay", true, false)
	if overlay:
		return overlay.get_node("ConfirmationBox")

func _on_save_game_pressed() -> void:
	var confirmation_box = get_confirmation_box()
	if not confirmation_box:
		return
		
	if Dialogic.Save.has_slot("autosave"):
		confirmation_box.show_confirmation("Are you sure you want to overwrite your existing saved game?")
	else:
		confirmation_box.show_confirmation("Would you like to save your game?")
	confirmation_box.confirmed.connect(_do_save, CONNECT_ONE_SHOT)


func _do_save() -> void:
	var extra_gamestate_data = {
		"drink_result": GameState.drink_result,
		"drink_hint": GameState.drink_hint,
		"target_drink": GameState.target_drink,
		"day": DayManager.day,
		"encounter": DayManager.encounter,
		"has_special_ingredient": GameState.has_special_ingredient,
		"has_seen_tutorial": GameState.has_seen_tutorial,
		"villain": GameState.villain,
		"gallery_unlocks": GameState.gallery_unlocks
	}
	
	Dialogic.Save.save("autosave", false, Dialogic.Save.ThumbnailMode.NONE, extra_gamestate_data)
	
	var confirmation_box = get_confirmation_box()
	if confirmation_box:
		confirmation_box.show_info("Successfully saved!")


func _on_load_game_pressed() -> void:
	var confirmation_box = get_confirmation_box()
	if not confirmation_box:
		return
		
	confirmation_box.show_confirmation("Would you like to load your saved game?")
	confirmation_box.confirmed.connect(_do_load, CONNECT_ONE_SHOT)


func _do_load() -> void:
	GameState.load_game()


func _on_main_menu_pressed() -> void:
	var confirmation_box = get_confirmation_box()
	if not confirmation_box:
		return
		
	confirmation_box.show_confirmation("Are you sure you want to go back to the main menu? Any unsaved progress will be lost.")
	confirmation_box.confirmed.connect(_do_main_menu, CONNECT_ONE_SHOT)


func _do_main_menu() -> void:
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
		
	# Hide drink mini game
	var mini_game = game_root.get_node_or_null("DrinkMiniGame")
	if mini_game:
		mini_game.visible = false
		
	# Hide pause
	visible = false


func _on_settings_pressed() -> void:
	get_tree().current_scene.get_node("PauseOverlay").open_settings_from_pause()


func _on_back_pressed() -> void:
	get_tree().current_scene.get_node("PauseOverlay").close_pause_menu()
