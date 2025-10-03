extends Control

@onready var start_btn = $Background/Panel/VBoxContainer/Resume
@onready var controls = $Background/Panel/VBoxContainer.get_children()

func _ready():
	hide()

# Handle pause input key ("esc")
func _input(event):
	if event.is_action_pressed("Pause"):
		_toggle_pause()

# Pause/Unpause game 
func _toggle_pause():
	if get_tree().paused:
		hide()
		get_tree().paused = false
	else:
		get_tree().paused = true
		show()
		await get_tree().process_frame		# Allow for frame for UI to update
		MenuSetup.load_intro_player(self, start_btn)
		MenuSetup.setup_controls(controls)
		start_btn.grab_focus()

# Unpause game
func _on_resume_button_down():
	_toggle_pause()

# Change scene to settings
func _on_settings_button_down():
	get_tree().paused = false  # Make sure game unpauses before scene change
	get_tree().change_scene_to_file("res://scenes/ui/settings_menu.tscn")

# Quit to main menu and warn user of unsaved gameplay
func _on_quit_to_menu_button_down():
	get_tree().paused = false  # Unpause before leaving
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
