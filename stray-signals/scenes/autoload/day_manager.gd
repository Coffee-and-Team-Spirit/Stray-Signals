extends Node

var day : int = 1
var encounter : int = 1

signal day_changed(new_day)


func get_current_timeline() -> String:
	print("TIMELINE : d%ss%s" % [day, encounter])
	return "d%ss%s" % [day, encounter]

func advance_encounter():
	encounter += 1
	
	if day == 4:
		if encounter == 3:
			if GameState.has_special_ingredient:
				encounter += 1
				return
			return
				
	if (encounter > 3) or (day == 1 && encounter > 2) or (day == 4 && encounter == 4 && !GameState.has_special_ingredient):
		encounter = 1
		day += 1
		emit_signal("day_changed", day)


func day_five_encounter():
	day = 5
	if GameState.villain == "Zara":
		encounter = 2
	elif GameState.villain == "GG":
		encounter = 3
	elif GameState.villain == "Alexandra":
		encounter = 4
	elif GameState.villain == "Whiskerly":
		encounter = 5
	elif GameState.villain == "Archimedes":
		encounter = 6
