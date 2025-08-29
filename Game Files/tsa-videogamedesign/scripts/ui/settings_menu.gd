extends Control

func _ready() -> void:
	$VBoxContainer/VBoxContainer/HBoxContainer/FullscreenCheck.grab_focus()

func _on_cancel_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
