extends Area2D

@onready var bullet_scene := preload("res://scenes/player/Bullet.tscn")
@export var min_shoot_time := 1.0
@export var max_shoot_time := 8.0

@onready var shoot_timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_timer()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)

func reset_timer():
	shoot_timer.wait_time = randf_range(min_shoot_time, max_shoot_time)
	shoot_timer.start()

func _on_Timer_timeout():
	shoot()
	reset_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
