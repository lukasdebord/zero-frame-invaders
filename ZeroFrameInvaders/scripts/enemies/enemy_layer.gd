extends TileMapLayer

@onready var enemy_timer = $Timer

const UPDATE_SPEED = 0.75	# Controls how often enemy pos is updated in seconds
const X_STEP = 5			# Controls how far enemies move side to side
const Y_STEP = 5			# Controls how far enemies move downwards

var left_boundary = -5
var right_boundary = 325
var descend = false
var direction = 1

var can_move = true		# used for pausing during animations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("enemy_layer")
	
	await get_tree().process_frame
	for enemy in get_children():
		if enemy is Timer:
			continue
		# Store enemy starting pos
		enemy.set_meta("start_position", enemy.global_position)
		
		var sprite = enemy.get_child(2)
		sprite.play("idle")
	
	# start enemy movement timer
	enemy_timer.start(UPDATE_SPEED)

func _process(_delta: float) -> void:
	pass
	

# Handles enemy movement every UPDATE_SPEED seconds
func _on_timer_timeout() -> void:
	if !can_move:
		return
	var edge_hit = false
	
	# Update enemy postion
	for enemy in get_children():
		if enemy is Timer:	continue
		
		# move enemies
		if descend:
			enemy.position.y += Y_STEP
		else:
			enemy.position.x += X_STEP * direction
			if enemy.position.x >= right_boundary || enemy.position.x <= left_boundary:
				edge_hit = true
	
	if descend:
		descend = false
	elif edge_hit:
		direction *= -1
		descend = true
	
	# restart timer
	enemy_timer.start(UPDATE_SPEED)
