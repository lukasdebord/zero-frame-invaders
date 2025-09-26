extends Node2D

@onready var anim_sprite = $CharacterBody2D/AnimatedSprite2D

const VELOCITY = 100

var disabled_scenes = ["MainMenu", "SettingsMenu", "PauseMenu", "Credits"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_script_status(get_tree().current_scene.name)

# Disable _process if user is in a menu
func set_script_status(curr_scene: String):
	for scene in disabled_scenes:
		if curr_scene == scene:
			set_process(false)

# Handle player's movment
func handle_player_movement(delta: float):
	# Move left
	if Input.is_action_pressed("Move_Left"):
		self.global_position.x -= VELOCITY * delta

	# Move right
	if Input.is_action_pressed("Move_Right"):
		self.global_position.x += VELOCITY * delta

	# Shoot bullet
	if Input.is_action_pressed("Shoot"):
		anim_sprite.play("shooting")
	else:
		anim_sprite.play("idle")		# Play idle animation



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check if game is paused
	if get_tree().paused:
		return


	handle_player_movement(delta)
