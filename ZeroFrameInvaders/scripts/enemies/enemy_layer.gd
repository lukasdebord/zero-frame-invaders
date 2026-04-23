extends TileMapLayer

const LINEAR_SPEED = 4.0
const PIXEL_STEP = 8		# Controls step distance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	for enemy in get_children():
		# Store enemy starting pos
		enemy.set_meta("start_position", enemy.global_position)
		
		var sprite = enemy.get_child(2)
		sprite.play("idle")


# Time equalizer for handling enemy movement
var time = 0.0
func handle_enemy_movement(delta: float):
	time += delta
	
	var x_offset = 0
	var y_offset = 0

	# Snaps enemies to a grid
	var raw_pos = Vector2(x_offset, y_offset)
	var snapped_pos = raw_pos.snapped(Vector2(PIXEL_STEP, PIXEL_STEP))

	# Update enemy position
	for enemy in get_children():
		var start_pos = enemy.get_meta("start_position")
		enemy.global_position = start_pos + snapped_pos


func _process(delta: float) -> void:
	handle_enemy_movement(delta)
	
