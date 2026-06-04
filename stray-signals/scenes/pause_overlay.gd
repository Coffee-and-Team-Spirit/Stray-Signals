extends CanvasLayer

func _ready():
	visible = false
	$Settings.visible = false
	$Pause.visible = true
	
	$Background.mouse_filter = Control.MOUSE_FILTER_STOP


func open_pause_menu() -> void:
	visible = true
	get_tree().paused = true
	Dialogic.paused = true 
	
	$Pause.visible = true
	$Settings.visible = false


func close_pause_menu() -> void:
	visible = false
	get_tree().paused = false
	Dialogic.paused = false
	
	$Pause.visible = false


func close_everything() -> void:
	visible = false
	
	Dialogic.end_timeline()
	
	get_tree().paused = false
	Dialogic.paused = false 
	
	$Settings.visible = false
	$Pause.visible = true


func open_settings_from_pause():
	$Settings.visible = true
	$Settings.get_node("Background").mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Settings.get_node("SubMenu").mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	if $Settings.has_node("Background"):
		$Settings.get_node("Background").visible = false
		
	if $Settings.has_node("SubMenu"):
		$Settings.get_node("SubMenu").visible = false


func _on_background_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		close_pause_menu()
