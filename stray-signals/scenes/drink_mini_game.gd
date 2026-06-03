extends Control

# Player selections
var chosen_cup : String = ""
var chosen_flavors : Array = []
var chosen_topping : String = ""
var chosen_modification : String = ""
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
	chosen_topping = topping_name
	update_cup_display()
	update_drink_components_display()
	print(chosen_topping)


func select_modification(modification_name):
	chosen_modification = modification_name
	update_cup_display()
	update_drink_components_display()
	print(chosen_modification)


func update_cup_display():
	player_drink_traits = {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": 0
	}
	
	if chosen_cup !="":
		$DrinkComponents/DrinkInformation/CupDisplay/CupBase.texture = load("res://assets/art/cups/empty_cup_%s.png" % chosen_cup)
		update_drink_traits(chosen_cup)
	else:
		$DrinkComponents/DrinkInformation/CupDisplay/CupBase.texture = load("res://assets/art/cups/empty_cup.png")
	
	if chosen_flavors.size() > 0:
		if chosen_flavors.size() == 1:
			$DrinkComponents/DrinkInformation/CupDisplay/BaseFlavorLayer.texture = load("res://assets/art/flavors/base_flavor_%s.png" % chosen_flavors[0])
		else:
			$DrinkComponents/DrinkInformation/CupDisplay/BaseFlavorLayer.texture = load("res://assets/art/flavors/base_flavor_%s.png" % chosen_flavors[0])
			$DrinkComponents/DrinkInformation/CupDisplay/SecondaryFlavorLayer.texture = load("res://assets/art/flavors/secondary_flavor_%s.png" % chosen_flavors[1])
			update_drink_traits(chosen_flavors[1])
		update_drink_traits(chosen_flavors[0])
	else:
		$DrinkComponents/DrinkInformation/CupDisplay/BaseFlavorLayer.texture = null
		$DrinkComponents/DrinkInformation/CupDisplay/SecondaryFlavorLayer.texture = null

	if chosen_topping != "":
		$DrinkComponents/DrinkInformation/CupDisplay/ToppingLayer.texture = load("res://assets/art/toppings/topping_%s.png" % chosen_topping)
		update_drink_traits(chosen_topping)
	else:
		$DrinkComponents/DrinkInformation/CupDisplay/ToppingLayer.texture = null
		
	if chosen_modification != "":
		update_drink_traits(chosen_modification)


func update_drink_components_display():
	var filled_panel_stylebox = load("res://ui/drink_components_panel_filled.tres")
	var unfilled_panel_stylebox = load("res://ui/drink_components_panel.tres")
	
	if chosen_cup != "":
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectCup.text = chosen_cup.capitalize()
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectCup/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectCup.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectCup.text = "Cup"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectCup/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectCup.add_theme_color_override("default_color", Color(0, 0, 0))

	if chosen_flavors.size() > 0:
		if chosen_flavors.size() == 1:
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.text = chosen_flavors[0].capitalize()
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
		else:
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.text = chosen_flavors[0].capitalize()
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
			
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.text = chosen_flavors[1].capitalize()
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.text = "Base Flavor"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.add_theme_color_override("default_color", Color(0, 0, 0))
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.text = "Secondary Flavor"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.add_theme_color_override("default_color", Color(0, 0, 0))	
	
	if chosen_topping != "":
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.text = chosen_topping.capitalize()
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.text = "Topping"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.add_theme_color_override("default_color", Color(0, 0, 0))
	
	if chosen_modification != "":
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification.text = chosen_modification.capitalize()
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification.text = "Modification"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification.add_theme_color_override("default_color", Color(0, 0, 0))


func get_flavor_category_id(value) -> int:
	if value >= 8:
		return 4      # extremely
	elif value >= 6:
		return 3      # very
	elif value == 5:
		return 2      # half
	elif value >= 3:
		return 1      # slight
	elif value >= 1:
		return 0      # hint
	else:
		return -1     # none


# Matches perfect
func matches_all(criteria, stats) -> bool:
	if criteria.has("ingredients"):
		var ing = criteria["ingredients"]
		if ing.has("flavors"):
			for f in ing["flavors"]:
				if f not in chosen_flavors:
					return false
					
		if ing.has("topping") and chosen_topping != ing["topping"]:
			return false
			
		if ing.has("cup") and chosen_cup != ing["cup"]:
			return false
		
		if ing.has("modification") and chosen_modification != ing["modification"]:
			return false
			
	if criteria.has("stats"):
		for key in criteria["stats"].keys():
			var required = criteria["stats"][key]
			var player = stats.get(key)
			
			if required is Array:
				if player not in required:
					return false
			else:
				if player != required:
					return false
	return true


# Matches good
func matches_any(criteria, stats) -> bool:
	var matched = false
	
	if criteria.has("ingredients"):
		var ing = criteria["ingredients"]
		
		if ing.has("flavors"):
			for f in ing["flavors"]:
				if f in chosen_flavors:
					matched = true
					
		if ing.has("topping") and chosen_topping == ing["topping"]:
			matched = true
		
		if ing.has("cup") and chosen_cup == ing["cup"]:
			matched = true
			
		if ing.has("modification") and chosen_modification == ing["modification"]:
			matched = true
			
	if criteria.has("stats"):
		for key in criteria["stats"].keys():
			var required = criteria["stats"][key]
			var player = stats.get(key)
			
			if required is Array:
				if player in required:
					matched = true
			else:
				if player == required:
					matched = true
	return matched

# Ingredient only puzzles
func count_matching_ingredients(target_ing) -> int:
	var count = 0
	
	if target_ing.has("flavors"):
		for f in target_ing["flavors"]:
			if f in chosen_flavors:
				count += 1
				
	if target_ing.has("topping") and chosen_topping == target_ing["topping"]:
		count += 1
		
	if target_ing.has("cup") and chosen_cup == target_ing["cup"]:
		count += 1
	
	if target_ing.has("modification") and chosen_modification == target_ing["modification"]:
		count += 1
	
	return count


func score_drink(puzzle, player_stats) -> int:
	var player_cat = {}
	for key in player_stats.keys():
		player_cat[key + "_category"] = get_flavor_category_id(player_stats[key])
		
	if matches_all(puzzle["perfect"], player_cat):
		return 3
		
	if matches_all(puzzle["good"], player_cat):
		return 2
		
	if puzzle["perfect"]["stats"].is_empty() and puzzle["perfect"]["ingredients"].size() > 0:
		var target_ing = puzzle["perfect"]["ingredients"]
		var matches = count_matching_ingredients(target_ing)
		
		if matches == target_ing.size():
			return 3
		elif matches == target_ing.size() - 1:
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
	GameState.drink_result = evaluate_drink_rating(score_drink(DrinkData.target_drinks[DayManager.day][DayManager.encounter], player_drink_traits))
	
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
	chosen_modification = ""
	
	player_drink_traits = {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": 0
	}
	
	$DrinkComponents/DrinkInformation/FlavorBars/FancyCozyBar/FancyBar.value = player_drink_traits["fancy_cozy"]
	$DrinkComponents/DrinkInformation/FlavorBars/FancyCozyBar/CozyBar.value = player_drink_traits["fancy_cozy"]
	$DrinkComponents/DrinkInformation/FlavorBars/BitterSweetBar/BitterBar.value = player_drink_traits["bitter_sweet"]
	$DrinkComponents/DrinkInformation/FlavorBars/BitterSweetBar/SweetBar.value = player_drink_traits["bitter_sweet"]
	$DrinkComponents/DrinkInformation/FlavorBars/CoolWarmBar/CoolBar.value = player_drink_traits["cool_warm"]
	$DrinkComponents/DrinkInformation/FlavorBars/CoolWarmBar/WarmBar.value = player_drink_traits["cool_warm"]
	
	pour_stage = 0
	
	update_cup_display()
	update_drink_components_display()


func start_pouring(flavor : String):
	is_pouring_flavor = true
	pour_flavor = flavor
	pour_amount = 0.0
	pour_stage = 0
	print("Pouring flavor: ", pour_flavor)


func _process(delta):
	is_pouring_action = Input.is_action_pressed("pour_flavor")
	
	if is_pouring_action && is_flavor_hovering && not is_pouring_flavor:
			start_pouring(current_hovered_flavor)
			
	if is_pouring_flavor and is_pouring_action:
		pour_amount += delta
		
		var required_pour_time = POUR_TIME if pour_stage == 0 else POUR_TIME * 2
		if pour_amount >= required_pour_time:
			finish_pouring(current_hovered_flavor)


func update_drink_traits(flavor_name):
	print("drink flavors ", player_drink_traits)
	if flavor_name in DrinkTraits.flavor_traits:
		var traits = DrinkTraits.flavor_traits[flavor_name]
		for key in traits.keys():
			player_drink_traits[key] += traits[key]
			
	if player_drink_traits["fancy_cozy"] <= 0:
		$DrinkComponents/DrinkInformation/FlavorBars/FancyCozyBar/FancyBar.value = abs(player_drink_traits["fancy_cozy"])
		$DrinkComponents/DrinkInformation/FlavorBars/FancyCozyBar/CozyBar.value = 0
	elif player_drink_traits["fancy_cozy"] > 0:
		$DrinkComponents/DrinkInformation/FlavorBars/FancyCozyBar/CozyBar.value = player_drink_traits["fancy_cozy"]
		$DrinkComponents/DrinkInformation/FlavorBars/FancyCozyBar/FancyBar.value = 0
	if player_drink_traits["bitter_sweet"] <= 0:
		$DrinkComponents/DrinkInformation/FlavorBars/BitterSweetBar/BitterBar.value = abs(player_drink_traits["bitter_sweet"])
		$DrinkComponents/DrinkInformation/FlavorBars/BitterSweetBar/SweetBar.value = 0
	elif player_drink_traits["bitter_sweet"] > 0:
		$DrinkComponents/DrinkInformation/FlavorBars/BitterSweetBar/SweetBar.value = player_drink_traits["bitter_sweet"]
		$DrinkComponents/DrinkInformation/FlavorBars/BitterSweetBar/BitterBar.value = 0
	if player_drink_traits["cool_warm"] <= 0:
		$DrinkComponents/DrinkInformation/FlavorBars/CoolWarmBar/CoolBar.value = abs(player_drink_traits["cool_warm"])
		$DrinkComponents/DrinkInformation/FlavorBars/CoolWarmBar/WarmBar.value = 0
	elif player_drink_traits["cool_warm"] > 0:
		$DrinkComponents/DrinkInformation/FlavorBars/CoolWarmBar/WarmBar.value = player_drink_traits["cool_warm"]
		$DrinkComponents/DrinkInformation/FlavorBars/CoolWarmBar/CoolBar.value = 0
	
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

func _ready():
	$DrinkComponents/DialogueHistory/DialogueHint.text = GameState.drink_hint
	$DrinkComponents/DialogueHistory/CharacterImage.texture.atlas = load("res://assets/art/characters/%s/%s_%s.png" % [GameState.current_character, GameState.current_character, GameState.current_portrait_info])
	$DrinkComponents/DialogueHistory/CharacterName.text = GameState.current_character
