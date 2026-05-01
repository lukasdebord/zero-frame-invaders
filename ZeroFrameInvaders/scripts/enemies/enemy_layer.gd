extends TileMapLayer

@onready var enemy_timer = $Timer

const UPDATE_SPEED = 1.0	# Controls how often enemy pos is updated in seconds
const X_SPEED = 5			# Controls how fast enemies move side to side
const Y_SPEED = 1			# Controls how fast enemies move downwards


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await get_tree().process_frame
	for enemy in get_children():
		if enemy is Timer:
			continue
		# Store enemy starting pos
		enemy.set_meta("start_position", enemy.global_position)
		
		var sprite = enemy.get_child(2)
		sprite.play("idle")


# Time equalizer for handling enemy movement
var time = 0.0
func handle_enemy_movement(delta: float):
	time += delta
	
	if enemy_timer.time_left == 0:
		
		# set enemy offset
		var x_offset = X_SPEED * time
		var y_offset = Y_SPEED * time
		
		# Update enemy postion
		for enemy in get_children():
			if enemy is Timer:
				continue
				
			var start_pos = enemy.get_meta("start_position")
			enemy.global_position = start_pos + Vector2(x_offset, y_offset)
		
		# restart timer
		enemy_timer.start(UPDATE_SPEED)


func _process(delta: float) -> void:
	handle_enemy_movement(delta)
	
