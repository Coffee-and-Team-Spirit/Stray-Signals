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
