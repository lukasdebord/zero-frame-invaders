extends Control

@onready var starting_slider = $VBoxContainer/MenuMargins/Menu/SoundSlider
@onready var controls = $VBoxContainer/Buttons.get_children() + $VBoxContainer/MenuMargins/Menu.get_children()

func _ready() -> void:
	starting_slider.grab_focus()
	
	MenuSetup.load_intro_player(self, starting_slider)
	MenuSetup.setup_controls(controls)
	
func _on_save_button_down() -> void:
	pass # Replace with function body.

func _on_cancel_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
