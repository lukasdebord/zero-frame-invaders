extends Control

@onready var buttons = $VBoxContainer/HBoxContainer.get_children()

func _ready() -> void:
	# Set input to keyboard only and grab focus
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$VBoxContainer/HBoxContainer/Play.grab_focus()

	MenuSetup.load_intro_player(self, Vector2(10, 10))
	MenuSetup.register_ship()
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
