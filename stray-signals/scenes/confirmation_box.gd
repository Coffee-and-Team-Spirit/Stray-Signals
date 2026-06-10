extends Control

signal confirmed
signal cancelled

enum Mode {CONFIRM, OKAY}
var current_mode: Mode = Mode.CONFIRM

func show_confirmation(message) -> void:
	current_mode = Mode.CONFIRM
	$Panel/MarginContainer/VBoxContainer/ConfirmationLabel.text = message
	$Panel/MarginContainer/VBoxContainer/HBoxContainer.visible = true
	$Panel/MarginContainer/VBoxContainer/OkButton.visible = false
	visible = true

func show_info(message: String):
	current_mode = Mode.OKAY
	$Panel/MarginContainer/VBoxContainer/ConfirmationLabel.text = message
	$Panel/MarginContainer/VBoxContainer/HBoxContainer.visible = false
	$Panel/MarginContainer/VBoxContainer/OkButton.visible = true
	visible = true


func _on_no_button_pressed() -> void:
	visible = false
	emit_signal("cancelled")


func _on_yes_button_pressed() -> void:
	visible = false
	emit_signal("confirmed")


func _on_ok_button_pressed():
	visible = false
	emit_signal("confirmed")
