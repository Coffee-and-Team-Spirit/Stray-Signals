extends Node2D

@export var drink_hint : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Dialogic.signal_event.is_connected(_on_signal):
		Dialogic.signal_event.connect(_on_signal)
	#Dialogic.signal_event.connect(_on_signal)
	
	#if Dialogic.get_full_state().timeline == "":
		#var current_timeline = DayManager.get_current_timeline()
		#Dialogic.start("res://timelines/%s.dtl" % current_timeline)
	
	Dialogic.VAR.set_variable("Drink.Rating", GameState.drink_result)
	GameState.target_drink = DrinkData.target_drinks[DayManager.day][DayManager.encounter]


func _on_signal(signal_passed_in):
	match signal_passed_in:
		"craft_drink":
			print("crafting drink...!")
			print("drink var ", Dialogic.VAR.get_variable("Drink.Rating"))
			
			# go to crafting drink mini-game
			Dialogic.end_timeline()
			
			var game_root = get_tree().current_scene
			var mini_game_scene = preload("res://scenes/drink_mini_game.tscn").instantiate()
			mini_game_scene.name = "DrinkMiniGame"
			
			game_root.add_child(mini_game_scene)
		
			# Show HUD
			get_tree().current_scene.get_node("HUD").visible = true

		"clear_drink":
			if GameState.drink_result != "bad":
				GameState.drink_hint = "none"
			GameState.drink_result = "none"
			Dialogic.VAR.set_variable("Drink.Rating", GameState.drink_result)
			
		"drink_hint":
			Dialogic.Text.about_to_show_text.connect(_on_about_to_show_text)
			
		"end_encounter":
			GameState.drink_hint = "none"
			GameState.drink_result = "none"
			Dialogic.VAR.set_variable("Drink.Rating", GameState.drink_result)
			
			#if Dialogic.Text.about_to_show_text.is_connected(_on_about_to_show_text):
				#Dialogic.Text.about_to_show_text.disconnect(_on_about_to_show_text)
			
			print("end_encounter flag")
			DayManager.advance_encounter()
			#Dialogic.end_timeline()
			var current_timeline = DayManager.get_current_timeline()
			print("DAY:", DayManager.day, " ENCOUNTER:", DayManager.encounter)
			Dialogic.start("res://timelines/%s.dtl" % current_timeline)


func _on_about_to_show_text(info: Dictionary):
	print("triggered")
	print(info)
	print(info.get("text"))
	print("CHARACTER IMAGE ", info.get("portrait"))
	
	var dialogue_drink_hint = info.get("text")
	if GameState.drink_hint == "none":
		GameState.drink_hint = dialogue_drink_hint

		var current_speaker = Dialogic.Text.get_current_speaker()
		GameState.current_character = current_speaker.display_name
		GameState.current_portrait_info = (Dialogic.Portraits.get_character_info(current_speaker))["portrait"]

		print("Gamestate: curr char ", GameState.current_character)
		print("Gamestate: curr portrait info ", GameState.current_portrait_info)
		
	Dialogic.Text.about_to_show_text.disconnect(_on_about_to_show_text)
