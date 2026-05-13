extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("test")
	Dialogic.signal_event.connect(_on_signal)

func _on_signal(signal_passed_in):
	match signal_passed_in:
		"craft_drink":
			print("crafting drink...!")
			# go to crafting drink mini-game
