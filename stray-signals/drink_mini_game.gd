extends Control

signal drink_result(result); # store the result of drink on 'serve' signal

# Player selections
var chosen_cup : String = ""
var chosen_flavors : Array = []
var chosen_topping : String = ""
var chosen_modification : String = ""

# Target drink, filled with a test drink for now 
var target_drink = {
	"cup": "boba_cup",
	"flavors": ["mango", "matcha"],
	"topping": "catnip",
	"modification": "shake"
}


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


var next_index := 0
func select_flavor(flavor_name):
	if chosen_flavors.size() < 2:
		chosen_flavors.append(flavor_name)
	else:
		chosen_flavors[next_index] = flavor_name
		next_index = 1 - next_index
	update_cup_display()
	update_drink_components_display()
	print(chosen_flavors)


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
	if chosen_cup !="":
		$DrinkInformation/CupDisplay/CupBase.texture = load("res://art/cups/empty_cup_%s.png" % chosen_cup)
	else:
		$DrinkInformation/CupDisplay/CupBase.texture = load("res://art/cups/empty_cup.png")
	
	if chosen_flavors.size() > 0:
		if chosen_flavors.size() == 1:
			$DrinkInformation/CupDisplay/BaseFlavorLayer.texture = load("res://art/flavors/base_flavor_%s.png" % chosen_flavors[0])
		else:
			$DrinkInformation/CupDisplay/BaseFlavorLayer.texture = load("res://art/flavors/base_flavor_%s.png" % chosen_flavors[0])
			$DrinkInformation/CupDisplay/SecondaryFlavorLayer.texture = load("res://art/flavors/secondary_flavor_%s.png" % chosen_flavors[1])
	else:
		$DrinkInformation/CupDisplay/BaseFlavorLayer.texture = null
		$DrinkInformation/CupDisplay/SecondaryFlavorLayer.texture = null

	if chosen_topping != "":
		$DrinkInformation/CupDisplay/ToppingLayer.texture = load("res://art/toppings/topping_%s.png" % chosen_topping)
	else:
		$DrinkInformation/CupDisplay/ToppingLayer.texture = null


func update_drink_components_display():
	var filled_panel_stylebox = load("res://ui/drink_components_panel_filled.tres")
	var unfilled_panel_stylebox = load("res://ui/drink_components_panel.tres")
	
	if chosen_cup != "":
		$DrinkInformation/MarginContainer/DrinkComponents/SelectCup.text = chosen_cup.capitalize()
		$DrinkInformation/MarginContainer/DrinkComponents/SelectCup/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkInformation/MarginContainer/DrinkComponents/SelectCup.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkInformation/MarginContainer/DrinkComponents/SelectCup.text = "Select Cup"
		$DrinkInformation/MarginContainer/DrinkComponents/SelectCup/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkInformation/MarginContainer/DrinkComponents/SelectCup.add_theme_color_override("default_color", Color(0, 0, 0))

	if chosen_flavors.size() > 0:
		if chosen_flavors.size() == 1:
			$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.text = chosen_flavors[0].capitalize()
			$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
		else:
			$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.text = chosen_flavors[0].capitalize()
			$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
			
			$DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.text = chosen_flavors[1].capitalize()
			$DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
			$DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.text = "Select Base Flavor"
		$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkInformation/MarginContainer/DrinkComponents/SelectBaseFlavor.add_theme_color_override("default_color", Color(0, 0, 0))
		$DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.text = "Select Secondary Flavor"
		$DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkInformation/MarginContainer/DrinkComponents/SelectSecondaryFlavor.add_theme_color_override("default_color", Color(0, 0, 0))	
	
	if chosen_topping != "":
		$DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.text = chosen_topping.capitalize()
		$DrinkInformation/MarginContainer/DrinkComponents/SelectTopping/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.text = "Select Topping"
		$DrinkInformation/MarginContainer/DrinkComponents/SelectTopping/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkInformation/MarginContainer/DrinkComponents/SelectTopping.add_theme_color_override("default_color", Color(0, 0, 0))
	
	if chosen_modification != "":
		$"DrinkInformation/MarginContainer/DrinkComponents/SelectModification".text = chosen_modification.capitalize()
		$DrinkInformation/MarginContainer/DrinkComponents/SelectModification/Panel.add_theme_stylebox_override("panel", filled_panel_stylebox)
		$DrinkInformation/MarginContainer/DrinkComponents/SelectModification.add_theme_color_override("default_color", Color(256, 256, 256))
	else:
		$"DrinkInformation/MarginContainer/DrinkComponents/SelectModification".text = "Select Modification"
		$DrinkInformation/MarginContainer/DrinkComponents/SelectModification/Panel.add_theme_stylebox_override("panel", unfilled_panel_stylebox)
		$DrinkInformation/MarginContainer/DrinkComponents/SelectModification.add_theme_color_override("default_color", Color(0, 0, 0))


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
	var player_drink_result = evaluate_drink_rating(score_drink())
	emit_signal("drink_result", player_drink_result)


func _on_reset_pressed() -> void:
	chosen_cup = ""
	chosen_flavors = []
	chosen_topping = ""
	chosen_modification = ""
	
	update_cup_display()
	update_drink_components_display()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
