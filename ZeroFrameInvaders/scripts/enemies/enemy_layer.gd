extends TileMapLayer

const X_FREQUENCY = 3
const X_AMPLITUDE = 0.35
const Y_FREQUENCY = 6
const Y_AMPLITUDE = 0.25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	for enemy in get_children():
		var sprite = enemy.get_node("Area2D/AnimatedSprite2D")
		sprite.play("idle")


# Time equalizer for handling enemy movement
var time = 0.0
func handle_enemy_movement(delta: float):
	time += delta
	# Cosinusoidal functions to control enemy movemement up and down and left and right
	var x_offset = cos(time * X_FREQUENCY) * X_AMPLITUDE
	var y_offset = cos(time * Y_FREQUENCY) * Y_AMPLITUDE
	for enemy in get_children():
		enemy.global_position += Vector2(x_offset, y_offset)


func handle_enemy_collision(collided_enemy: Node2D):
	pass


func _process(delta: float) -> void:
	handle_enemy_movement(delta)
