extends Control

func _ready() -> void:
	$VBoxContainer2/HBoxContainer/FullscreenCheck.grab_focus()


func _on_save_button_down() -> void:
	pass # Replace with function body.

func _on_cancel_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
