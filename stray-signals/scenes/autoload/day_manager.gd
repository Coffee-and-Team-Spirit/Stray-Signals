extends Node

var day : int = 1
var encounter : int = 1


func get_current_timeline() -> String:
	print("TIMELINE : d%ss%s" % [day, encounter])
	return "d%ss%s" % [day, encounter]

func advance_encounter():
	encounter += 1
	if (encounter > 3) or (day == 1 && encounter > 2):
		encounter = 1
		day += 1
