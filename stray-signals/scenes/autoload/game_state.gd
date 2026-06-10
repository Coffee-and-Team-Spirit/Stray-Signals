extends Node

# GameState variables
var drink_result : String = "none"
var drink_hint : String = "none"
var current_character: String = "none"
var current_portrait_info : String = "none"
var target_drink : Dictionary = {}
var has_special_ingredient : bool = false
var has_seen_tutorial : bool = false
var villain : String = "none"

var settings_return_target := "main_menu"

func new_game() -> void:
	drink_result = "none"
	drink_hint = "none"
	target_drink = {}
	current_character = "none"
	current_portrait_info = "none"
	has_special_ingredient = false
	has_seen_tutorial = false
	villain = "none"
	
	DayManager.day = 1
	DayManager.encounter = 1
	
	#if Dialogic.Save.has_slot("autosave"):
		#Dialogic.Save.delete_slot("autosave")
		
	var game_root = get_tree().current_scene
		
	# Instance gameplay scene
	var main_scene = preload("res://scenes/main.tscn").instantiate()
	game_root.add_child(main_scene)
		
	# Show HUD
	game_root.get_node("HUD").visible = true
	
	# Start first timeline
	var first_timeline = DayManager.get_current_timeline()
	Dialogic.start("res://timelines/%s.dtl" % first_timeline)


func load_game() -> void:
	if Dialogic.Save.has_slot("autosave"):
		var game_data = Dialogic.Save.get_slot_info("autosave")
		
		drink_result = game_data.get("drink_result", "none")
		drink_hint = game_data.get("drink_hint", "none")
		target_drink = game_data.get("target_drink", {})
		has_special_ingredient  = game_data.get("has_special_ingredient", false)
		has_seen_tutorial = game_data.get("has_seen_tutorial", false)
		villain = game_data.get("villain", "none")
		DayManager.day = game_data.get("day", 1)
		DayManager.encounter = game_data.get("encounter", 1)
		
		DayManager.emit_signal("day_changed", DayManager.day)
		
		print("LOAD")
		Dialogic.Save.load("autosave")
	
	# Instance gameplay scene
	var main_scene = preload("res://scenes/main.tscn").instantiate()
	get_tree().current_scene.add_child(main_scene)
	
	# Show HUD
	get_tree().current_scene.get_node("HUD").visible = true
