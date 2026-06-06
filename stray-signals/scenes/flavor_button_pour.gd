extends TextureButton


func _get_drag_data(_position):
	var flavor_preview = TextureRect.new()
	flavor_preview.texture = texture_normal
	flavor_preview.expand = true
	flavor_preview.custom_minimum_size = Vector2(128, 128)  # force visible size
	flavor_preview.modulate = Color(1, 1, 1, 1)  # force full opacity
	flavor_preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	flavor_preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	set_drag_preview(flavor_preview)
	return name


func _notification(what):
	if what == NOTIFICATION_DRAG_BEGIN or what == NOTIFICATION_DRAG_END:
		var drink_mini_game = get_tree().get_root().find_child("DrinkMiniGame", true, false)
		if drink_mini_game:
			drink_mini_game.is_flavor_hovering = false
			drink_mini_game.current_hovered_flavor = ""
