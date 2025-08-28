extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$VBoxContainer/HBoxContainer/Play.grab_focus()

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/intro_scene.tscn")


func _on_settings_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/settings_menu.tscn")


func _on_exit_button_down() -> void:
	get_tree().quit()
