extends CharacterBody2D

@onready var anim_sprite = $AnimationPlayer
@onready var timer = $Timer
@onready var life_icons = [
	get_node("/root/IntroScene/ColorRect/GameUI/VBoxContainer/Lives/Life1"),
	get_node("/root/IntroScene/ColorRect/GameUI/VBoxContainer/Lives/Life2"),
	get_node("/root/IntroScene/ColorRect/GameUI/VBoxContainer/Lives/Life3")
]
@onready var BulletScene := preload("res://scenes/player/Bullet.tscn")


var can_control = true

const VELOCITY = 100

var disabled_scenes = ["MainMenu", "SettingsMenu", "PauseMenu", "Credits"]
var fire_rate = 0.4 		# Seconds between shots (0.2 to match animation)
var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Determine whether player should move in current scene
	set_script_status(get_tree().current_scene.name)
	
	# Start timer and set fire rate
	timer.wait_time = fire_rate
	timer.start()



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

	# Shoot bullet if within fire rate range
	if Input.is_action_pressed("Shoot") and timer.is_stopped():
		shoot_bullet()
		anim_sprite.play("shoot")
		timer.start()


func shoot_bullet():
	var bullet = BulletScene.instantiate()		# Spawn Bullet
	bullet.z_index = 0
	bullet.is_enemy_bullet = false		# change bullet to player owned
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = self.global_position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check if game is paused
	if get_tree().paused || !can_control:
		return
	
	# Handle players movement
	handle_player_movement(delta)

# signal for when animations are finished
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# remove life if hit and reset animation
	if anim_name == "death":
		anim_sprite.play("idle")
		
		lives -= 1
		if lives > 0:
			life_icons[lives].hide()
		# end game if player dies
		elif lives == 0:
			get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
			return
			
		can_control = true
		var enemy_layer = get_tree().get_first_node_in_group("enemy_layer")
		enemy_layer.can_move = true
		enemy_layer.enemy_timer.paused = false
		
		global_position.x = 160.0		# reset player position
