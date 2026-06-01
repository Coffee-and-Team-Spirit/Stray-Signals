extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	focus_mode = Control.FOCUS_NONE
	$"../../Day/DayText".text = "Day " + str(DayManager.day)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_button_pressed() -> void:
	var root = get_tree().current_scene  # GameRoot
	var pause = root.get_node("Pause")
	
	pause.open_pause_menu()
