extends TileMapLayer

const X_FREQUENCY = 2		# Controls speed of horizontal movement
const X_AMPLITUDE = 20		# Controls horizontal range
const Y_FREQUENCY = 4		# Controls speed of vertical movement
const Y_AMPLITUDE = 5		# Controls vertical range


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	for enemy in get_children():
		# Store enemy starting pos
		enemy.set_meta("start_position", enemy.global_position)
		
		var sprite = enemy.get_node("AnimatedSprite2D")
		sprite.play("idle")


# Time equalizer for handling enemy movement
var time = 0.0
func handle_enemy_movement(delta: float):
	time += delta
	# Sinusoidal functions to control enemy movemement up and down and left and right
	var x_offset = X_AMPLITUDE * sin(X_FREQUENCY * time)
	var y_offset = Y_AMPLITUDE * sin(Y_FREQUENCY * time)
	for enemy in get_children():
		var start_pos = enemy.get_meta("start_position")
		enemy.global_position = start_pos + Vector2(x_offset, y_offset)


func handle_enemy_collision(collided_enemy: Node2D):
	pass


func _process(delta: float) -> void:
	handle_enemy_movement(delta)
	
