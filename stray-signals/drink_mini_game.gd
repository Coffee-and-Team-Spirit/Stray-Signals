extends Control

signal drink_finished(result); # store the result of drink on 'serve' signal

# Player selections
var chosen_cup : String = ""
var chosen_flavors : Array = []
var chosen_topping : String = ""
var chosen_modification : String = ""
var next_index := 0 # track what flavor layer the player is on

# Flavor bar tracking
var drink_traits = {
	"fancy_cozy": 0,
	"bitter_sweet": 0,
	"cool_warm": 0
}

var flavor_traits = {
	"boba_cup": {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": 0
	},
	"mug": {
		"fancy_cozy": 50,
		"bitter_sweet": 0,
		"cool_warm": 10
	},
	"wine_glass": {
		"fancy_cozy": -50,
		"bitter_sweet": 0,
		"cool_warm": -10
	},
	"coffee": {
		"fancy_cozy": 20,
		"bitter_sweet": -50,
		"cool_warm": 20
	},
	"mango": {
		"fancy_cozy": 0,
		"bitter_sweet": 60,
		"cool_warm": 0
	},
	"matcha": {
		"fancy_cozy": 30,
		"bitter_sweet": -30,
		"cool_warm": 10
	},
	"milk_tea": {
		"fancy_cozy": 20,
		"bitter_sweet": 20,
		"cool_warm": 0
	},
	"strawberry": {
		"fancy_cozy": -10,
		"bitter_sweet": 30,
		"cool_warm": -30
	},
	"boba": {
		"fancy_cozy": 20,
		"bitter_sweet": 30,
		"cool_warm": 0
	},
	"catnip": {
		"fancy_cozy": -30,
		"bitter_sweet": -80,
		"cool_warm": 0
	},
	"cream_and_treats": {
		"fancy_cozy": 0,
		"bitter_sweet": 50,
		"cool_warm": 0
	},
	"chill": {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": -40
	},
	"heat": {
		"fancy_cozy": 40,
		"bitter_sweet": 0,
		"cool_warm": 40
	},
	"shake": {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": -10
	},
	"stir": {
		"fancy_cozy": -10,
		"bitter_sweet": 0,
		"cool_warm": -10
	}
}

# Target drink, filled with a test drink for now 
var target_drink = {
	"cup": "boba_cup",
	"flavors": ["mango", "matcha"],
	"topping": "catnip",
	"modification": "shake"
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

const POUR_TIME : float = 0.2


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
	drink_traits = {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": 0
	}
	
	if chosen_cup !="":
		$DrinkComponents/DrinkInformation/CupDisplay/CupBase.texture = load("res://art/cups/empty_cup_%s.png" % chosen_cup)
		update_drink_traits(chosen_cup)
	else:
		$DrinkComponents/DrinkInformation/CupDisplay/CupBase.texture = load("res://art/cups/empty_cup.png")
	
	if chosen_flavors.size() > 0:
		if chosen_flavors.size() == 1:
			$DrinkComponents/DrinkInformation/CupDisplay/BaseFlavorLayer.texture = load("res://art/flavors/base_flavor_%s.png" % chosen_flavors[0])
		else:
			$DrinkComponents/DrinkInformation/CupDisplay/BaseFlavorLayer.texture = load("res://art/flavors/base_flavor_%s.png" % chosen_flavors[0])
			$DrinkComponents/DrinkInformation/CupDisplay/SecondaryFlavorLayer.texture = load("res://art/flavors/secondary_flavor_%s.png" % chosen_flavors[1])
			update_drink_traits(chosen_flavors[1])
		update_drink_traits(chosen_flavors[0])
	else:
		$DrinkComponents/DrinkInformation/CupDisplay/BaseFlavorLayer.texture = null
		$DrinkComponents/DrinkInformation/CupDisplay/SecondaryFlavorLayer.texture = null

	if chosen_topping != "":
		$DrinkComponents/DrinkInformation/CupDisplay/ToppingLayer.texture = load("res://art/toppings/topping_%s.png" % chosen_topping)
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
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectCup.text = "Select Cup"
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
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.text = "Select Base Flavor"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.add_theme_color_override("default_color", Color(0, 0, 0))
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.text = "Select Secondary Flavor"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.add_theme_color_override("default_color", Color(0, 0, 0))	
	
	if chosen_topping != "":
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.text = chosen_topping.capitalize()
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.text = "Select Topping"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.add_theme_color_override("default_color", Color(0, 0, 0))
	
	if chosen_modification != "":
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification.text = chosen_modification.capitalize()
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification.text = "Select Modification"
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkComponents/DrinkInformation/MarginContainer/DrinkComponents/SelectModification.add_theme_color_override("default_color", Color(0, 0, 0))


func score_drink() -> int:
	var score = 0
	
	if chosen_cup == target_drink["cup"]:
		score += 1
	
	for flavor in chosen_flavors:
		if flavor in target_drink["flavors"]:
			score += 1
	
	if chosen_topping == target_drink["topping"]:
		score += 1
	
	if chosen_modification == target_drink["modification"]:
		score += 1
		
	print(score)
	return score


func evaluate_drink_rating(score) -> String:
	if score >= 4:
		print("Congrats, you made a Good drink!")
		return "good"
	elif score >= 2:
		print("You made a Mediocre drink... better luck next time.")
		return "mediocre"
	else:
		print("This drink is soooo Bad, I need a remake.")
		return "bad"


func _on_serve_pressed() -> void:
	GameState.drink_result = evaluate_drink_rating(score_drink())
	#GameState.drink_finished.emit(player_drink_result)
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_reset_pressed() -> void:
	chosen_cup = ""
	chosen_flavors = []
	chosen_topping = ""
	chosen_modification = ""
	
	drink_traits = {
		"fancy_cozy": 0,
		"bitter_sweet": 0,
		"cool_warm": 0
	}
	
	$DrinkComponents/FlavorBars/FancyCozyBar/FancyBar.value = drink_traits["fancy_cozy"]
	$DrinkComponents/FlavorBars/FancyCozyBar/CozyBar.value = drink_traits["fancy_cozy"]
	$DrinkComponents/FlavorBars/BitterSweetBar/BitterBar.value = drink_traits["bitter_sweet"]
	$DrinkComponents/FlavorBars/BitterSweetBar/SweetBar.value = drink_traits["bitter_sweet"]
	$DrinkComponents/FlavorBars/CoolWarmBar/CoolBar.value = drink_traits["cool_warm"]
	$DrinkComponents/FlavorBars/CoolWarmBar/WarmBar.value = drink_traits["cool_warm"]
	
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
			finish_pouring()

func update_drink_traits(flavor_name):
	print("drink flavors ", drink_traits)
	if flavor_name in flavor_traits:
		var traits = flavor_traits[flavor_name]
		for key in traits.keys():
			drink_traits[key] += traits[key]
			
	if drink_traits["fancy_cozy"] < 0:
		$DrinkComponents/FlavorBars/FancyCozyBar/FancyBar.value = abs(drink_traits["fancy_cozy"])
	elif drink_traits["fancy_cozy"] > 0:
		$DrinkComponents/FlavorBars/FancyCozyBar/CozyBar.value = drink_traits["fancy_cozy"]
	if drink_traits["bitter_sweet"] < 0:
		$DrinkComponents/FlavorBars/BitterSweetBar/BitterBar.value = abs(drink_traits["bitter_sweet"])
	elif drink_traits["bitter_sweet"] > 0:
		$DrinkComponents/FlavorBars/BitterSweetBar/SweetBar.value = drink_traits["bitter_sweet"]
	if drink_traits["cool_warm"] < 0:
		$DrinkComponents/FlavorBars/CoolWarmBar/CoolBar.value = abs(drink_traits["cool_warm"])
	elif drink_traits["cool_warm"] > 0:
		$DrinkComponents/FlavorBars/CoolWarmBar/WarmBar.value = drink_traits["cool_warm"]
	
	print("updated drink flavors ", drink_traits)


func finish_pouring():
	if pour_stage == 0:
		next_index = 0
		select_flavor(pour_flavor)
		pour_stage = 1;
		pour_amount = 0.0
		
		if not is_pouring_action:
			is_pouring_flavor = false
		
		print("BASE FLAVOR: ", pour_flavor)
	else:
		next_index = 1
		select_flavor(pour_flavor)
		pour_stage = 0;
		pour_amount = 0.0
		
		is_pouring_flavor = false
		is_pouring_action = false
		print("SECONDARY FLAVOR: ", pour_flavor)
	print("FINISH POURING: ", chosen_flavors)
