extends Control

const SAVE_PATH = "res://configs/settings.cfg"
const BUS_SECTION = "Audio"

@onready var starting_slider = $VBoxContainer/MenuMargins/Menu/SoundSlider
@onready var controls = $VBoxContainer/Buttons.get_children() + $VBoxContainer/MenuMargins/Menu.get_children()

@export var bus_name: String = "Master"
var bus_index: int


func _ready() -> void:
	starting_slider.grab_focus()
	
	MenuSetup.load_intro_player(self, starting_slider)
	MenuSetup.setup_controls(controls)
	
	# get index of bus when the game starts
	bus_index = AudioServer.get_bus_index(bus_name)



func _on_save_button_down() -> void:
	pass # Replace with function body.

func _on_cancel_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _on_quit_button_down() -> void:
	get_tree().quit()


# set volume to value of slider
func _on_sound_slider_value_changed(value: float) -> void:
	var db_val = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	# print("volume: ", db_to_linear(AudioServer.get_bus_volume_db(bus_index)))



func save_settings(db_val: float):
	# create new config file
	var config = ConfigFile.new()
	
	# save volume settings
	config.set_value(BUS_SECTION, bus_name, db_val)
	config.save(SAVE_PATH)
	

#func load_settings():
#	var config = ConfigFile.new()
#	var error = config.load(SAVE_PATH)
#	
#	# If no file exists, use Godot's current engine volume
#	if error != OK:
#		var current_db = AudioServer.get_bus_volume_db(bus_index)
#		value = db_to_linear(current_db)
#		return
#		
#	# Fetch only this bus value, default to current engine volume if missing
#	var default_db = AudioServer.get_bus_volume_db(bus_index)
#	var saved_db = config.get_value(BUS_SECTION, bus_name, default_db)
#	
#	# Apply to engine and update the UI slider position
#	AudioServer.set_bus_volume_db(bus_index, saved_db)
#	value = db_to_linear(saved_db)
