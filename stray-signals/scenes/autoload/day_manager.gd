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
		_unlock("cafe_background")
		_unlock("loren_neutral")
		_unlock("loren_happy")
		_unlock("loren_sad")
		_unlock("loren_angry")
		_unlock("cup")
		_unlock("mug")
		_unlock("glass")
		_unlock("boba")
		_unlock("catnip")
		_unlock("cream_and_cat_treats")
		_unlock("strawberry")
		_unlock("mango")
		_unlock("coffee")
		_unlock("matcha")
		_unlock("milk_tea")
	if day > 2:
		_unlock("archimedes_neutral")
		_unlock("archimedes_sad")
		_unlock("archimedes_happy")
		_unlock("alexandra_neutral")
		_unlock("alexandra_happy")
		_unlock("alexandra_sad")
		_unlock("alexandra_angry")
		_unlock("gg_neutral")
		_unlock("gg_happy")
		_unlock("gg_sad")
		_unlock("gg_angry")
	if day > 3:
		_unlock("whiskerly_neutral")
		_unlock("whiskerly_sad")
		_unlock("whiskerly_happy")
		_unlock("zara_neutral")
		_unlock("zara_sad")
		_unlock("zara_happy")
	if GameState.has_special_ingredient == true:
		_unlock("magical_mushroom_fish")
	if DayManager.day == 5:
		_unlock("ending_background")


func _unlock(id: String):
	if GalleryData.gallery_data.has(id):
		GalleryData.gallery_data[id]["unlocked"] = true
		GameState.gallery_unlocks[id] = true
