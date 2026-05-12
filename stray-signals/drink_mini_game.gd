extends Control

signal drink_result(result); # store the result of drink on 'serve' signal

# Player selections
var chosen_cup : String = "";
var chosen_flavors : Array = [];
var chosen_topping : String = "";
var chosen_modification : String = "";

# Target drink 
var target_drink = {
	"cup": "",
	"flavors": [],
	"topping": "",
	"modification": ""
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
	print(chosen_cup)


var next_index := 0
func select_flavor(flavor_name):
	if chosen_flavors.size() < 2:
		chosen_flavors.append(flavor_name)
	else:
		chosen_flavors[next_index] = flavor_name
		next_index = 1 - next_index
		
	print(chosen_flavors)


func select_topping(topping_name):
	chosen_topping = topping_name
	print(chosen_topping)


func select_modification(modification_name):
	chosen_modification = modification_name
	print(chosen_modification)

func update_cup_display():
	$DrinkDisplay/CupDisplay/CupBase.texture = load("res://art/cups/empty_cup_%s.png" % chosen_cup)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
