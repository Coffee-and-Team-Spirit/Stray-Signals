extends Node

func _ready():
	$HUD.visible = false  # hidden until gameplay starts

	# Pause menu exists for the whole game
	$Pause.visible = false
	
	# Main menu should be visible on startup
	$MainMenu.visible = true
