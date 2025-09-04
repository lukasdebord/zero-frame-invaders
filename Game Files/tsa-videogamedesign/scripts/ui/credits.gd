extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Return.grab_focus()

func _on_return_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
