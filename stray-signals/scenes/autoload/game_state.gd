extends Node

# GameState variables
var drink_result : String = "none"
var drink_hint : String = "none"
var current_character: String = "none"
var current_portrait_info : String = "none"
var target_drink : Dictionary = {}

var settings : Dictionary = {
	"music": 1.0,
	"sfx": 1.0,
	"text": 1.0
}

func load_game() -> void:
	if Dialogic.Save.has_slot("autosave"):
		var game_data = Dialogic.Save.get_slot_info("autosave")
		
		GameState.drink_result = game_data.get("drink_result", "none")
		GameState.drink_hint = game_data.get("drink_hint", "none")
		GameState.target_drink = game_data.get("target_drink", {})
		DayManager.day = game_data.get("day", 1)
		DayManager.encounter = game_data.get("encounter", 1)
		
		print("LOAD")
		Dialogic.Save.load("autosave")
