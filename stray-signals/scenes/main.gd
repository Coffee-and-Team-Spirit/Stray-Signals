extends Node2D

var hud_scene = preload("res://scenes/HUD.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_signal)
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
			GameState.drink_result = "none"
			Dialogic.VAR.set_variable("Drink.Rating", GameState.drink_result)
	  
	  
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
