extends Control

@onready var ship = $VBoxContainer/HBoxContainer/PlayerCursor
@onready var buttons = $VBoxContainer/HBoxContainer.get_children()

func _ready() -> void:
	# Set input to keyboard only and grab focus
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$VBoxContainer/HBoxContainer/Play.grab_focus()
	
	MenuSetup.register_ship(ship)
	MenuSetup.setup_buttons(buttons)

# Change scene to intro
func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/intro_scene.tscn")

# Change scene to settings
func _on_settings_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/settings_menu.tscn")

# Change scene to credits
func _on_credits_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")

# Quit game
func _on_quit_button_down() -> void:
	get_tree().quit()
