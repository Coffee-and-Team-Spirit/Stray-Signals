extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
	Dialogic.end_timeline()
	
	var root = get_tree().current_scene  # This is GameRoot
	
	# Remove gameplay scene
	var main = root.get_node_or_null("Main")
	if main:
		main.queue_free()
		
	# Show main menu
	var menu = root.get_node_or_null("MainMenu")
	if menu:
		menu.visible = true
		
	# Hide HUD
	var hud = root.get_node_or_null("HUD")
	if hud:
		hud.visible = false

	# Hide pause
	visible = false


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_background_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		hide()


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = false
