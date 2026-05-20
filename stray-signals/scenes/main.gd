extends Node2D

var hud_scene = preload("res://scenes/HUD.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hud_instance = hud_scene.instantiate()
	if GameState.drink_result == "":
		Dialogic.start("res://timelines/d1s1.dtl")
		Dialogic.signal_event.connect(_on_signal)
		add_child(hud_instance)
	else:
		Dialogic.VAR.set_variable("Drink.Rating", GameState.drink_result)
		Dialogic.start("res://timelines/d1s1.dtl", "d1s1_drink_rating")
		GameState.drink_result = ""

func _on_signal(signal_passed_in):
	match signal_passed_in:
		"craft_drink":
			print("crafting drink...!")
			
			# go to crafting drink mini-game
			Dialogic.end_timeline()
			get_tree().change_scene_to_file("res://drink_mini_game.tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
