extends Node

var main_scene: Node = null
var main_scene_resource := preload("res://scenes/main.tscn")
var hud_scene := preload("res://scenes/hud.tscn")

func _ready():
	# HUD exists for the whole game
	var hud = hud_scene.instantiate()
	add_child(hud)
	hud.visible = false  # hidden until gameplay starts

	# Pause menu exists for the whole game
	$Pause.visible = false
	
	# Main menu should be visible on startup
	$MainMenu.visible = true
