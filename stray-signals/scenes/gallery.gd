extends Control

const GALLERY_PATH = "res://assets/art/gallery/"
const LOCKED = preload("res://assets/temp/lock.png")
const ITEMS_PER_PAGE = 6
var current_page : int = 0
var total_pages : int = 0
var gallery_ids : Array = []


func _ready() -> void:
	var gallery_button = $SubMenu/MenuBackground/MarginContainer/MainMenuContainer/Gallery
	gallery_button.disabled = true
	gallery_button.set_pressed_no_signal(true)
	
	DayManager.gallery_unlocks()
	
	gallery_ids = GameState.gallery_unlocks.keys()
	gallery_ids.sort_custom(Callable(self, "_sort_by_unlock"))
	total_pages = int(ceil(float(gallery_ids.size()) / ITEMS_PER_PAGE))
	
	setup_pagination_buttons()
	update_pagination_buttons()
	populate_page(current_page)


func setup_pagination_buttons():
	for i in range($SettingsBackground/Pagination.get_child_count()):
		$SettingsBackground/Pagination.get_child(i).visible = false
		
	for i in range(total_pages):
		var panel := $SettingsBackground/Pagination.get_child(i)
		panel.visible = true
		
		var button = panel.get_child(0)
		button.connect("button_down", Callable(self, "_on_gallery_pressed").bind(i))


func _on_gallery_pressed(page_index):
	current_page = page_index
	update_pagination_buttons()
	populate_page(current_page)


func update_pagination_buttons():
	for i in range($SettingsBackground/Pagination.get_child_count()):
		var panel := $SettingsBackground/Pagination.get_child(i)
		
		if i < total_pages:
			var button := panel.get_child(0)
			button.disabled = (i == current_page)
		else:
			panel.visible = false


func populate_page(page_index):
	var start = page_index * ITEMS_PER_PAGE
	var end = min(start + ITEMS_PER_PAGE, gallery_ids.size())
	var page_items = gallery_ids.slice(start, end)
	
	for i in range(page_items.size()):
		var id = page_items[i]
		var unlocked = GameState.gallery_unlocks[id]
		
		var art_piece = $SettingsBackground/MarginContainer/GridContainer.get_child(i)
		var texture_rect = art_piece.get_node("TextureRect")
		var label = art_piece.get_node("RichTextLabel")
			
		if unlocked:
			texture_rect.texture = load(GALLERY_PATH + id + ".png")
			label.text = id.replace("_", " ").capitalize()
		else:
			texture_rect.texture = LOCKED
			label.text = "LOCKED"
			
		art_piece.visible = true
		
		texture_rect.set_meta("id", id)
		if not texture_rect.gui_input.is_connected(_on_gallery_item_input):
			texture_rect.gui_input.connect(Callable(self, "_on_gallery_item_input").bind(texture_rect))
		
	for i in range(page_items.size(), $SettingsBackground/MarginContainer/GridContainer.get_child_count()):
		$SettingsBackground/MarginContainer/GridContainer.get_child(i).visible = false


func _sort_by_unlock(a, b):
	var unlocked_a = GameState.gallery_unlocks[a]
	var unlocked_b = GameState.gallery_unlocks[b]
	
	if unlocked_a != unlocked_b:
		return unlocked_a
	return a < b


func _on_gallery_item_input(event: InputEvent, texture_rect):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var id = texture_rect.get_meta("id")
		
		if not GameState.gallery_unlocks[id]:
			return
			
		_show_expanded_view(id)
		print("HELLLO")


func _show_expanded_view(id):
	$ExpandedView/Panel/MarginContainer/TextureRect.texture = load(GALLERY_PATH + id + ".png")
	$ExpandedView/Title.text = id.replace("_", " ").capitalize()
	$ExpandedView.visible = true


func _close_fullscreen() -> void:
	$ExpandedView.visible = false


func _on_overlay_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		_close_fullscreen()
