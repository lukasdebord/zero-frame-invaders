extends Control

func _on_return_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
