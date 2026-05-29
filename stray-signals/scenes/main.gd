extends Node2D

var hud_scene = preload("res://scenes/hud.tscn")
@export var drink_hint : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_signal)
	#Dialogic.Text.about_to_show_text.connect(_on_about_to_show_text)
	
	Dialogic.VAR.set_variable("Drink.Rating", GameState.drink_result)	
	Dialogic.start("res://timelines/d1s1.dtl")
	
	var hud_instance = hud_scene.instantiate()
	add_child(hud_instance)


func _on_signal(signal_passed_in):
	match signal_passed_in:
		"craft_drink":
			print("crafting drink...!")
			print("drink var ", Dialogic.VAR.get_variable("Drink.Rating"))
			
			# go to crafting drink mini-game
			Dialogic.end_timeline()
			get_tree().change_scene_to_file("res://scenes/drink_mini_game.tscn")

		"clear_drink":
			if GameState.drink_result != "bad":
				GameState.drink_hint = "none"
			GameState.drink_result = "none"
			Dialogic.VAR.set_variable("Drink.Rating", GameState.drink_result)
			
		"drink_hint":
			Dialogic.Text.about_to_show_text.connect(_on_about_to_show_text)


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


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
