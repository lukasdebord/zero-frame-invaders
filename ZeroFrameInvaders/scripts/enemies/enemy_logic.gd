extends Area2D

@onready var bullet_scene := preload("res://scenes/player/Bullet.tscn")
@export var min_shoot_time := 1.0
@export var max_shoot_time := 20.0

@onready var shoot_timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_timer()

# spawn for bullets
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)

# set random time for bullets to be shot
func reset_timer():
	shoot_timer.wait_time = randf_range(min_shoot_time, max_shoot_time)
	shoot_timer.start()

func _on_timer_timeout():
	shoot()
	reset_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# signal for animation finished
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# enemy dies
	if anim_name == "death":
		queue_free()
