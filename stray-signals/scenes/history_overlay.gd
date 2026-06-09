extends CanvasLayer

var selected_day : int = 0

func _ready() -> void:
	Dialogic.History.simple_history_changed.connect(_on_history_entry_added)


func _on_history_entry_added() -> void:
	var raw_day = Dialogic.VAR.get_variable("CurrentDay")
	var current_day: int = int(raw_day) if raw_day != null else 1
	
	var history_array: Array = Dialogic.History.simple_history_content
	if history_array.is_empty():
		return
		
	var latest_entry: Dictionary = history_array.back()
	
	if not latest_entry.has("extra_info"):
		latest_entry["extra_info"] = {}
		
	latest_entry["extra_info"]["day_number"] = current_day


func open_history():
	populate_day_list()
	visible = true
	
	var dialogue_list = $Panel/MarginContainer/MarginContainer/MarginContainer/ScrollContainer/VBoxContainer
	
	for child in dialogue_list.get_children():
		child.queue_free()
		
	$Panel/MarginContainer/MarginContainer/Day.text = "NOTEBOOK HISTORY"
	$Panel/MarginContainer2/DayList/Day1.disabled = false
	$Panel/MarginContainer2/DayList/Day2.disabled = false
	$Panel/MarginContainer2/DayList/Day3.disabled = false
	$Panel/MarginContainer2/DayList/Day4.disabled = false
	$Panel/MarginContainer2/DayList/Day5.disabled = false


func close_history():
	visible = false


func get_history_by_day() -> Dictionary:
	var history = Dialogic.History.get_simple_history()
	print("HISTORY ", history)
	var grouped_day := {}
	
	for entry in history:
		var day: int = 0
		if entry.has("extra_info") and entry["extra_info"].has("day_number"):
			day = entry["extra_info"]["day_number"]
			
		if day == 0:
			continue
		
		if not grouped_day.has(day):
			grouped_day[day] = []
		grouped_day[day].append(entry)
			
	return grouped_day


func populate_day_list():
	var grouped_day = get_history_by_day()
	var day_list = $Panel/MarginContainer2/DayList
	
	for button in day_list.get_children():
		button.visible = false
		
	var day_keys = grouped_day.keys()
	day_keys.sort() 
	
	for day in day_keys:
		var button_name = "Day%d" % day
		if day_list.has_node(button_name):
			var day_button = day_list.get_node(button_name)
			day_button.visible = true
			
			day_button.disabled = (day == selected_day)
			if selected_day != 0:
				$Panel/MarginContainer/MarginContainer/Day.text = "DAY " + str(selected_day)


func _on_show_day(day: int) -> void:
	selected_day = day
	var grouped_day = get_history_by_day()
	
	print("GROUPED DAY ", grouped_day)
	var dialogue_list = $Panel/MarginContainer/MarginContainer/MarginContainer/ScrollContainer/VBoxContainer
	for child in dialogue_list.get_children():
		child.queue_free()
		
	for entry in grouped_day[day]:
		var label = RichTextLabel.new()
		label.bbcode_enabled = true
		label.fit_content = true
		
		var speaker = entry.get("character", "Narrator")
		var text = entry.get("text", "")
		
		print("SPEAKER ", speaker)
		print("TEXT ", text)
		
		label.text = "[b]%s:[/b] %s" % [speaker, text]
		label.bbcode_enabled = true
		label.fit_content = true
		label.add_theme_color_override("default_color", Color.BLACK)
		label.custom_minimum_size = Vector2(1000, 40)
		print("LABEL TEXT ", label.text)
		dialogue_list.add_child(label)


func _on_background_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		close_history()


func _on_back_pressed() -> void:
	close_history()


func _on_day_button_pressed(button_path: NodePath) -> void:
	print("BUTTON ", button_path)
	var button: Button = get_node(button_path)
	var day = button.get_meta("day_number")
	if day == null:
		return
	
	selected_day = day
	populate_day_list()
	_on_show_day(day)
