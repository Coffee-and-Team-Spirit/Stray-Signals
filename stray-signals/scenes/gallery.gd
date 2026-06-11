extends Control

const GALLERY_PATH = "res://assets/art/gallery/"
const LOCKED = preload("res://assets/temp/lock.png")
const ITEMS_PER_PAGE = 6
var current_page : int = 0
var total_pages : int = 0
var gallery_ids : Array = []


func _ready() -> void:
	var credits_button = $SubMenu/MenuBackground/MarginContainer/MainMenuContainer/Gallery
	credits_button.disabled = true
	credits_button.set_pressed_no_signal(true)
	
	DayManager.gallery_unlocks()
	
	gallery_ids = GameState.gallery_unlocks.keys()
	gallery_ids.sort()
	total_pages = int(ceil(float(gallery_ids.size()) / ITEMS_PER_PAGE))
	
	setup_pagination_buttons()
	update_pagination_buttons()
	populate_page(current_page)
	
func setup_pagination_buttons():
	for i in range($SubMenu/SettingsBackground/Pagination.get_child_count()):
		$SubMenu/SettingsBackground/Pagination.get_child(i).visible = false
		
	for i in range(total_pages):
		var panel := $SubMenu/SettingsBackground/Pagination.get_child(i)
		panel.visible = true
		
		var button = panel.get_child(0)
		button.connect("button_down", Callable(self, "_on_gallery_pressed").bind(i))


func _on_gallery_pressed(page_index):
	current_page = page_index
	update_pagination_buttons()
	populate_page(current_page)


func update_pagination_buttons():
	for i in range($SubMenu/SettingsBackground/Pagination.get_child_count()):
		var panel := $SubMenu/SettingsBackground/Pagination.get_child(i)
		
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
		
		var art_piece = $SubMenu/SettingsBackground/MarginContainer/GridContainer.get_child(i)
		var texture_rect = art_piece.get_node("TextureRect")
			
		if unlocked:
			texture_rect.texture = load(GALLERY_PATH + id + ".png")
		else:
			texture_rect.texture = LOCKED
			
		art_piece.visible = true
		
	for i in range(page_items.size(), $SubMenu/SettingsBackground/MarginContainer/GridContainer.get_child_count()):
		$SubMenu/SettingsBackground/MarginContainer/GridContainer.get_child(i).visible = false
