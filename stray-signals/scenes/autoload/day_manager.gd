extends Node

var day : int = 1
var encounter : int = 1

signal day_changed(new_day)


func get_current_timeline() -> String:
	Dialogic.VAR.set_variable("CurrentDay", DayManager.day)
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
	
	gallery_unlocks()


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


func gallery_unlocks():
	if day > 1:
		GameState.gallery_unlocks["cafe_background"] = true
		GameState.gallery_unlocks["loren_neutral"] = true
		GameState.gallery_unlocks["loren_happy"] = true
		GameState.gallery_unlocks["loren_sad"] = true
		GameState.gallery_unlocks["loren_angry"] = true
		GameState.gallery_unlocks["cup"] = true
		GameState.gallery_unlocks["mug"] = true
		GameState.gallery_unlocks["glass"] = true
		GameState.gallery_unlocks["boba"] = true
		GameState.gallery_unlocks["catnip"] = true
		GameState.gallery_unlocks["cream_and_cat_treats"] = true
		GameState.gallery_unlocks["strawberry"] = true
		GameState.gallery_unlocks["mango"] = true
		GameState.gallery_unlocks["coffee"] = true
		GameState.gallery_unlocks["matcha"] = true
		GameState.gallery_unlocks["milk_tea"] = true
	if day > 2:
		GameState.gallery_unlocks["archimedes_neutral"] = true
		GameState.gallery_unlocks["archimedes_sad"] = true
		GameState.gallery_unlocks["archimedes_happy"] = true
		GameState.gallery_unlocks["alexandra_neutral"] = true
		GameState.gallery_unlocks["alexandra_happy"] = true
		GameState.gallery_unlocks["alexandra_sad"] = true
		GameState.gallery_unlocks["alexandra_angry"] = true
		GameState.gallery_unlocks["gg_neutral"] = true
		GameState.gallery_unlocks["gg_happy"] = true
		GameState.gallery_unlocks["gg_sad"] = true
		GameState.gallery_unlocks["gg_angry"] = true
	if day > 3:
		GameState.gallery_unlocks["whiskerly_neutral"] = true
		GameState.gallery_unlocks["whiskerly_sad"] = true
		GameState.gallery_unlocks["whiskerly_happy"] = true
		GameState.gallery_unlocks["zara_neutral"] = true
		GameState.gallery_unlocks["zara_sad"] = true
		GameState.gallery_unlocks["zara_happy"] = true
	if GameState.has_special_ingredient == true:
		GameState.gallery_unlocks["magical_mushroom_fish"] = true
	if DayManager.day == 5:
		GameState.gallery_unlocks["ending_background"] = true
