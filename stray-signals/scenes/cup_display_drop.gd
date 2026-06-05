extends Control


func _can_drop_data(_position, data):
	if data.to_snake_case().begins_with("flavor_"):
		var drink_mini_game = get_tree().get_root().find_child("DrinkMiniGame", true, false)
		
		if drink_mini_game:
			drink_mini_game.is_flavor_hovering = true
			drink_mini_game.current_hovered_flavor = data.to_snake_case().replace("flavor_", "")
			
			if drink_mini_game.is_pouring_action && not drink_mini_game.is_pouring_flavor:
				drink_mini_game.start_pouring(drink_mini_game.current_hovered_flavor)
			return true
	return false 


func _drop_data(_position, data):
	var drink_mini_game = get_tree().get_root().find_child("DrinkMiniGame", true, false)
	if drink_mini_game:
		var flavor_name = data.to_snake_case().replace("flavor_", "")
		drink_mini_game.is_flavor_hovering = true
		drink_mini_game.current_hovered_flavor = flavor_name
