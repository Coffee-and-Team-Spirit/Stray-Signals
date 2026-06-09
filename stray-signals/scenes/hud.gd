extends TextureButton


func _ready() -> void:
	focus_mode = Control.FOCUS_NONE
	DayManager.day_changed.connect(_on_day_changed)
	_on_day_changed(DayManager.day)

func _on_day_changed(new_day):
	$"../../Day/DayText".text = "Day " + str(new_day)

func _on_menu_button_pressed() -> void:
	var root = get_tree().current_scene  # GameRoot
	var pause = root.get_node("PauseOverlay")
	
	pause.open_pause_menu()


func _on_notebook_button_pressed() -> void:
	var root = get_tree().current_scene  # GameRoot
	var history = root.get_node("HistoryOverlay")
	
	history.open_history()
