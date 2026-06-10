extends Control

# Player selections
var chosen_cup : String = ""
var chosen_flavors : Array = []
var chosen_topping : String = ""
var chosen_modification : String = ""
var chosen_special_topping : String = ""
var next_index : int = 0 # track what flavor layer the player is on

# Flavor bar tracking
var player_drink_traits = {
	"fancy_cozy": 0,
	"bitter_sweet": 0,
	"cool_warm": 0
}

# Drag and pour with action key P
var is_dragging_flavor : bool = false # track ingredient dragging
var is_flavor_hovering : bool = false # track flavor hovering above cup
var current_hovered_flavor : String = "" # track what flavor is hovering
var is_pouring_flavor : bool = false # game state
var is_pouring_action : bool = false # action key P

var pour_flavor : String = ""
var pour_amount : float = 0.0
var pour_stage : int = 0

const POUR_TIME : float = 0.3


func _on_cup_button_pressed(button_path: NodePath):
	var button = get_node(button_path)
	var cup_name = button.name.to_snake_case().replace("cup_", "")
	select_cup(cup_name)


func _on_flavor_button_pressed(button_path: NodePath):
	var button = get_node(button_path)
	var flavor_name = button.name.to_snake_case().replace("flavor_", "")
	select_flavor(flavor_name)


func _on_topping_button_pressed(button_path: NodePath):
	var button = get_node(button_path)
	var topping_name = button.name.to_snake_case().replace("topping_", "")
	select_topping(topping_name)


func _on_modification_button_pressed(button_path: NodePath):
	var button = get_node(button_path)
	var modification_name = button.name.to_snake_case().replace("modification_", "")
	select_modification(modification_name)


func select_cup(cup_name):
	chosen_cup = cup_name
	update_cup_display()
	update_drink_components_display()
	print(chosen_cup)


func select_flavor(flavor_name):
	if chosen_flavors.size() < 2:
		chosen_flavors.append(flavor_name)
	else:
		chosen_flavors[next_index] = flavor_name
		next_index = 1 - next_index
		
	update_cup_display()
	update_drink_components_display()
	print("CHOSEN FLAVORS: ", chosen_flavors)


func select_topping(topping_name):
	#DayManager.day = 5
	if topping_name == "magical_mushroom_fish":
		if DayManager.day == 5:
			chosen_special_topping = topping_name
			$ToppingSelector/ToppingMagicalMushroomFish.visible = true
		else:
			var confirmation_box = $ConfirmationBox
			if confirmation_box:
				confirmation_box.show_info("Rememeber, Zara suggested to save the special ingredient to stop the villain.")
	else:
		chosen_topping = topping_name
	update_cup_display()
	update_drink_components_display()
	print(chosen_topping)


func select_modification(modification_name):
	chosen_modification = modification_name
	update_cup_display()
	update_drink_components_display()
	
	match modification_name:
		"heat":
			modification_sparkle(Color.INDIAN_RED)
		"chill":
			modification_sparkle(Color.SKY_BLUE)
		"shake":
			modification_sparkle(Color.LIME_GREEN)
		"stir":
			modification_sparkle(Color.MEDIUM_PURPLE)
			
	print(chosen_modification)


func update_cup_display():
	player_drink_traits = {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": 0
	}
	
	if chosen_cup !="":
		$CupDisplay/CupBase.texture = load("res://assets/art/mini_game/cups/empty_cup_%s.png" % chosen_cup)
		update_drink_traits(chosen_cup)
	else:
		$CupDisplay/CupBase.texture = load("res://assets/art/mini_game/cups/empty_cup_cup.png")
	
	if chosen_flavors.size() > 0:
		if chosen_flavors.size() == 1:
			$CupDisplay/CupBase/BaseFlavorLayer.texture = load("res://assets/art/mini_game/flavors/base_flavor_%s_%s.png" % [chosen_flavors[0], chosen_cup])
		else:
			$CupDisplay/CupBase/BaseFlavorLayer.texture = load("res://assets/art/mini_game/flavors/base_flavor_%s_%s.png" % [chosen_flavors[0], chosen_cup])
			$CupDisplay/CupBase/SecondaryFlavorLayer.texture = load("res://assets/art/mini_game/flavors/secondary_flavor_%s_%s.png" % [chosen_flavors[1], chosen_cup])
			update_drink_traits(chosen_flavors[1])
		update_drink_traits(chosen_flavors[0])
	else:
		$CupDisplay/CupBase/BaseFlavorLayer.texture = null
		$CupDisplay/CupBase/SecondaryFlavorLayer.texture = null
		
	if chosen_topping != "":
		$CupDisplay/ToppingLayer.texture = load("res://assets/art/mini_game/toppings/topping_%s_%s.png" % [chosen_topping, chosen_cup])
		update_drink_traits(chosen_topping)
	else:
		$CupDisplay/ToppingLayer.texture = null
		
	if chosen_special_topping != "":
		$CupDisplay/SpecialToppingLayer.texture = load("res://assets/art/mini_game/toppings/topping_%s_%s.png" % [chosen_special_topping, chosen_cup])
		update_drink_traits(chosen_special_topping)
	else:
		$CupDisplay/SpecialToppingLayer.texture = null
		
	if chosen_modification != "":
		update_drink_traits(chosen_modification)


func update_drink_components_display():
	var filled_panel_stylebox = load("res://ui/drink_components_panel_filled.tres")
	var unfilled_panel_stylebox = load("res://ui/drink_components_panel.tres")
	
	if chosen_cup != "":
		$DrinkInformation/SelectCup.text = chosen_cup.capitalize()
		$DrinkInformation/SelectCup/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkInformation/SelectCup.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkInformation/SelectCup.text = "Cup"
		$DrinkInformation/SelectCup/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)

	if chosen_flavors.size() > 0:
		if chosen_flavors.size() == 1:
			$DrinkInformation/SelectBaseFlavor.text = chosen_flavors[0].capitalize()
			$DrinkInformation/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkInformation/SelectBaseFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
		else:
			$DrinkInformation/SelectBaseFlavor.text = chosen_flavors[0].capitalize()
			$DrinkInformation/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkInformation/SelectBaseFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
			
			$DrinkInformation/SelectSecondaryFlavor.text = chosen_flavors[1].capitalize()
			$DrinkInformation/SelectSecondaryFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkInformation/SelectSecondaryFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkInformation/SelectBaseFlavor.text = "Base Flavor"
		$DrinkInformation/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkInformation/SelectSecondaryFlavor.text = "Secondary Flavor"
		$DrinkInformation/SelectSecondaryFlavor/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
	
	if chosen_topping != "":
		$DrinkInformation/SelectTopping.text = chosen_topping.capitalize()
		$DrinkInformation/SelectTopping/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkInformation/SelectTopping.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkInformation/SelectTopping.text = "Topping"
		$DrinkInformation/SelectTopping/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		
	if chosen_special_topping != "":
		$DrinkInformation/SelectSpecialTopping.text = chosen_special_topping.capitalize()
		$DrinkInformation/SelectSpecialTopping/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkInformation/SelectSpecialTopping.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkInformation/SelectSpecialTopping.text = "Special Ingredient"
		$DrinkInformation/SelectSpecialTopping/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		
	if chosen_modification != "":
		$DrinkInformation/SelectModification.text = chosen_modification.capitalize()
		$DrinkInformation/SelectModification/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkInformation/SelectModification.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkInformation/SelectModification.text = "Modification"
		$DrinkInformation/SelectModification/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)


func get_flavor_category_id(flavor_name, value) -> Dictionary:
	var direction := "neutral"
	
	if flavor_name == "fancy_cozy":
		if value < 0:
			direction = "fancy"
		elif value > 0:
			direction = "cozy"
	elif flavor_name == "bitter_sweet":
		if value < 0:
			direction = "bitter"
		elif value > 0:
			direction = "sweet"
	elif flavor_name == "cool_warm":
		if value < 0:
			direction = "cool"
		elif value > 0:
			direction = "warm"
		
	var abs_value = abs(value)
	var intensity = -1;
	
	if abs_value >= 8:
		intensity = 4      # extremely
	elif abs_value >= 6:
		intensity = 3      # very
	elif abs_value == 5:
		intensity = 2      # half
	elif abs_value >= 3:
		intensity = 1      # slight
	elif abs_value >= 1:
		intensity = 0      # hint
		
	return {
		"direction": direction,
		"intensity": intensity
	}


# Matches perfect/good
func matches_all(criteria, stats) -> bool:
	print("CRITERIA: ", criteria)
	print("STATS: ", stats)
	
	if criteria.has("ingredients"):
		var target_ingredients = criteria["ingredients"]
		if target_ingredients.has("flavors"):
			for f in target_ingredients["flavors"]:
				if f not in chosen_flavors:
					return false
		
		if target_ingredients.has("flavors_or"):
			var ok := false
			for f in target_ingredients["flavors_or"]:
				if f in chosen_flavors:
					ok = true
					break
				if not ok:
					return false
					
		if target_ingredients.has("flavors_not"):
			for f in target_ingredients["flavors_not"]:
				if f in chosen_flavors:
					return false
					
		if target_ingredients.has("topping") and chosen_topping != target_ingredients["topping"]:
			return false
			
		if target_ingredients.has("special_topping") and chosen_special_topping != target_ingredients["special_topping"]:
			return false
			
		if target_ingredients.has("cup") and chosen_cup != target_ingredients["cup"]:
			return false
		
		if target_ingredients.has("modification") and chosen_modification != target_ingredients["modification"]:
			return false
			
	if criteria.has("stats"):
		for key in criteria["stats"].keys():
			var required = criteria["stats"][key]
			var player = stats.get(key)
			
			if key.ends_with("_intensity"):
				var direction_key = key.replace("_intensity", "_direction")
				var direction = stats.get(direction_key, "neutral")
				
				if not criteria["stats"].has(direction_key):
					if direction == "cozy":
						player = 0
					if direction =="bitter":
						player = 0
					if direction == "cool":
						player = 0
			
			print("REQUIRED!!!! ", required)
			print("PLAYER ", player)
			
			if key.ends_with("_direction") and player == "neutral":
				continue
				
			if required is Array:
				if player not in required:
					return false
			else:
				if player != required:
					return false
	return true


# Matches good/mediocre
func matches_any(criteria, stats) -> bool:
	var matched = false
	
	if criteria.has("ingredients"):
		var target_ingredients = criteria["ingredients"]
		
		if target_ingredients.has("flavors"):
			for f in target_ingredients["flavors"]:
				if f in chosen_flavors:
					matched = true
				
		if target_ingredients.has("flavors_or"):
			var ok := false
			for f in target_ingredients["flavors_or"]:
				if f in chosen_flavors:
					ok = true
					break
				if not ok:
					return false
					
		if target_ingredients.has("flavors_not"):
			for f in target_ingredients["flavors_not"]:
				if f in chosen_flavors:
					return false
					
		if target_ingredients.has("topping") and chosen_topping == target_ingredients["topping"]:
			matched = true
			print("TOPPING MATCH ", matched)
			
		if target_ingredients.has("special_topping") and chosen_special_topping == target_ingredients["special_topping"]:
			matched = true
			
		if target_ingredients.has("cup") and chosen_cup == target_ingredients["cup"]:
			matched = true
			
		if target_ingredients.has("modification") and chosen_modification == target_ingredients["modification"]:
			matched = true
			
	if criteria.has("stats"):
		for key in criteria["stats"].keys():
			var required = criteria["stats"][key]
			var player = stats.get(key)
			
			if key.ends_with("_direction") and player == "neutral":
				matched = true
				continue
				
			if required is Array:
				if player in required:
					matched = true
			else:
				if player == required:
					matched = true
	return matched

# Ingredient only puzzles
func count_matching_ingredients(target_ingredients) -> int:
	var count = 0
	
	if target_ingredients.has("flavors"):
		for f in target_ingredients["flavors"]:
			if f in chosen_flavors:
				count += 1
				
	if target_ingredients.has("topping") and chosen_topping == target_ingredients["topping"]:
		count += 1
		
	if target_ingredients.has("cup") and chosen_cup == target_ingredients["cup"]:
		count += 1
	
	if target_ingredients.has("modification") and chosen_modification == target_ingredients["modification"]:
		count += 1
	
	return count


func score_drink(puzzle, player_stats) -> int:
	var player_category = {}
	for key in player_stats.keys():
		var result = get_flavor_category_id(key, player_stats[key])
		player_category[key + "_direction"] = result.direction
		player_category[key + "_intensity"] = result.intensity
	
	if (DayManager.day == 3 && DayManager.encounter == 2) or (DayManager.day == 4 && DayManager.encounter == 3):
		if chosen_flavors[0] == chosen_flavors[1]:
			return 0
			
	print("PLAYER STATS ", player_stats)
	print("PLAYER CATEGORY ", player_category)
	if matches_all(puzzle["perfect"], player_category):
		return 3
		
	if matches_all(puzzle["good"], player_category) or matches_any(puzzle["good"], player_category):
		return 2
		
	if puzzle["perfect"]["stats"].is_empty() and puzzle["perfect"]["ingredients"].size() > 0:
		var target_ingredients = puzzle["perfect"]["ingredients"]
		var matches = count_matching_ingredients(target_ingredients)
		
		if matches == target_ingredients.size():
			return 3
		elif matches == target_ingredients.size() - 1:
			return 2
		else:
			return 0
			
	return 0


func evaluate_drink_rating(score) -> String:
	if score == 3:
		print("Congrats, you made a Good drink!")
		return "good"
	elif score == 2:
		print("You made a Mediocre drink... better luck next time.")
		return "mediocre"
	
	print("This drink is soooo Bad, I need a remake.")
	return "bad"


func _on_serve_pressed() -> void:
	print("SERVE DAY ", DayManager.day)
	print("SERVE ENCOUNTER ", DayManager.encounter)
	print("VILLAIN ", GameState.villain)
	GameState.drink_result = evaluate_drink_rating(score_drink(DrinkData.drink_puzzles[DayManager.day][DayManager.encounter], player_drink_traits))
	
	var game_root = get_tree().current_scene
	queue_free()
	
	game_root.get_node("HUD").visible = true
	
	Dialogic.VAR.set_variable("Drink.Rating", GameState.drink_result)

	var current_timeline = DayManager.get_current_timeline()
	print("DEBUG TIMELINE: ", current_timeline)
	Dialogic.start("res://timelines/%s.dtl" % current_timeline, "drink_rating")


func _on_reset_pressed() -> void:
	chosen_cup = ""
	chosen_flavors = []
	chosen_topping = ""
	chosen_special_topping = ""
	$DrinkInformation/SelectSpecialTopping.visible = false
	chosen_modification = ""
	
	player_drink_traits = {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": 0
	}
	
	$FlavorMeters/MarginContainer/FlavorBars/FancyCozyBar/FancyBar.value = player_drink_traits["fancy_cozy"]
	$FlavorMeters/MarginContainer/FlavorBars/FancyCozyBar/CozyBar.value = player_drink_traits["fancy_cozy"]
	$FlavorMeters/MarginContainer/FlavorBars/BitterSweetBar/BitterBar.value = player_drink_traits["bitter_sweet"]
	$FlavorMeters/MarginContainer/FlavorBars/BitterSweetBar/SweetBar.value = player_drink_traits["bitter_sweet"]
	$FlavorMeters/MarginContainer/FlavorBars/CoolWarmBar/CoolBar.value = player_drink_traits["cool_warm"]
	$FlavorMeters/MarginContainer/FlavorBars/CoolWarmBar/WarmBar.value = player_drink_traits["cool_warm"]
	
	pour_stage = 0
	
	$CupDisplayFX/SparkleParticles.restart()
	$CupDisplayFX/SparkleParticles.emitting = false
	
	update_cup_display()
	update_drink_components_display()


func start_pouring(flavor : String):
	is_pouring_flavor = true
	pour_flavor = flavor
	pour_amount = 0.0
	pour_stage = 0
	print("Pouring flavor: ", pour_flavor)


func update_drink_traits(flavor_name):
	print("drink flavors ", player_drink_traits)
	if flavor_name in DrinkTraits.flavor_traits:
		var traits = DrinkTraits.flavor_traits[flavor_name]
		for key in traits.keys():
			player_drink_traits[key] += traits[key]
			
	if player_drink_traits["fancy_cozy"] <= 0:
		$FlavorMeters/MarginContainer/FlavorBars/FancyCozyBar/FancyBar.value = abs(player_drink_traits["fancy_cozy"])
		$FlavorMeters/MarginContainer/FlavorBars/FancyCozyBar/CozyBar.value = 0
	elif player_drink_traits["fancy_cozy"] > 0:
		$FlavorMeters/MarginContainer/FlavorBars/FancyCozyBar/CozyBar.value = player_drink_traits["fancy_cozy"]
		$FlavorMeters/MarginContainer/FlavorBars/FancyCozyBar/FancyBar.value = 0
	if player_drink_traits["bitter_sweet"] <= 0:
		$FlavorMeters/MarginContainer/FlavorBars/BitterSweetBar/BitterBar.value = abs(player_drink_traits["bitter_sweet"])
		$FlavorMeters/MarginContainer/FlavorBars/BitterSweetBar/SweetBar.value = 0
	elif player_drink_traits["bitter_sweet"] > 0:
		$FlavorMeters/MarginContainer/FlavorBars/BitterSweetBar/SweetBar.value = player_drink_traits["bitter_sweet"]
		$FlavorMeters/MarginContainer/FlavorBars/BitterSweetBar/BitterBar.value = 0
	if player_drink_traits["cool_warm"] <= 0:
		$FlavorMeters/MarginContainer/FlavorBars/CoolWarmBar/CoolBar.value = abs(player_drink_traits["cool_warm"])
		$FlavorMeters/MarginContainer/FlavorBars/CoolWarmBar/WarmBar.value = 0
	elif player_drink_traits["cool_warm"] > 0:
		$FlavorMeters/MarginContainer/FlavorBars/CoolWarmBar/WarmBar.value = player_drink_traits["cool_warm"]
		$FlavorMeters/MarginContainer/FlavorBars/CoolWarmBar/CoolBar.value = 0
	
	print("updated drink flavors ", player_drink_traits)


func finish_pouring(flavor):
	if pour_stage == 0:
		next_index = 0
		select_flavor(flavor)
		pour_stage = 1;
		pour_amount = 0.0
		
		if not is_pouring_action:
			is_pouring_flavor = false
		
		print("BASE FLAVOR: ", flavor)
	else:
		next_index = 1
		select_flavor(flavor)
		pour_stage = 0;
		pour_amount = 0.0
		
		is_pouring_flavor = false
		is_pouring_action = false
		print("SECONDARY FLAVOR: ", flavor)
		
	print("FINISH POURING: ", chosen_flavors)


func modification_sparkle(color):
	var sparkle = $CupDisplayFX/SparkleParticles
	sparkle.modulate = color
	sparkle.restart()
	$CupDisplayFX/SparkleParticles.emitting = true


func show_tutorial():
	var tutorial := preload("res://scenes/tutorial_overlay.tscn").instantiate()
	get_tree().current_scene.add_child(tutorial)
	tutorial.start_tutorial()


func _ready():
	#GameState.has_seen_tutorial = true
	#GameState.has_special_ingredient = true
	var game_root = get_tree().current_scene
	game_root.get_node("HUD").visible = false
	
	if not GameState.has_seen_tutorial:
		GameState.has_seen_tutorial = true
		await get_tree().create_timer(2.0).timeout
		show_tutorial()
		
	if GameState.has_special_ingredient:
		$ToppingSelector/ToppingMagicalMushroomFish.visible = true
		
	$Customer/MarginContainer/DialogueHistory/Panel/MarginContainer/DialogueHint.text = GameState.drink_hint
	$Customer/MarginContainer/DialogueHistory/CharacterImage.texture.atlas = load("res://assets/art/characters/%s/%s_%s.png" % [GameState.current_character, GameState.current_character, GameState.current_portrait_info])
		
	match GameState.current_character:
		"Alexandra":
			$Customer/MarginContainer/DialogueHistory/CharacterImage.texture.region.position.y = 50
		"Archimedes":
			$Customer/MarginContainer/DialogueHistory/CharacterImage.texture.region.position.y = 350
		"GG":
			$Customer/MarginContainer/DialogueHistory/CharacterImage.texture.region.position.y = 400
		"Loren":
			$Customer/MarginContainer/DialogueHistory/CharacterImage.texture.region.position.y = 25
		"Whiskerly":
			$Customer/MarginContainer/DialogueHistory/CharacterImage.texture.region.position.y = 325
		"Zara":
			$Customer/MarginContainer/DialogueHistory/CharacterImage.texture.region.position.y = 150
	
	$Customer/MarginContainer/DialogueHistory/CharacterName.text = GameState.current_character


func _process(delta):
	is_pouring_action = Input.is_action_pressed("pour_flavor")
	
	if is_pouring_action && is_flavor_hovering && not is_pouring_flavor:
			start_pouring(current_hovered_flavor)
			
	if is_pouring_flavor and is_pouring_action:
		pour_amount += delta
		
		var required_pour_time = POUR_TIME if pour_stage == 0 else POUR_TIME * 2
		if pour_amount >= required_pour_time:
			finish_pouring(current_hovered_flavor)
