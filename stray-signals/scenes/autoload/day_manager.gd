extends Node

var day : int = 1
var encounter : int = 1


func get_current_timeline() -> String:
	return "d%ss%s" % [day, encounter]

func advance_encounter():
	encounter += 1
	if encounter > 3:
		encounter = 1
		day += 1
