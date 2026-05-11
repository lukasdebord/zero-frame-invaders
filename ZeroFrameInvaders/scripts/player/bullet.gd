extends Area2D

const SPEED = 175
var direction = Vector2.ZERO
var is_enemy_bullet = true


func _ready():
	# Set bullet direction to down for enemies and up for player
	if is_enemy_bullet == true:
		direction = Vector2.DOWN
	elif is_enemy_bullet == false:
		direction = Vector2.UP
	
	connect("area_entered", Callable(self, "_on_collision"))


func _process(delta):
	# Bullet movement
	position += direction * SPEED * delta
	
	# Remove bullet if offscreen
	if not get_viewport_rect().has_point(global_position):
		queue_free()


# bullet collision with enemy
func _on_collision(collided_object: Node) -> void:
	var enemy = get_node("/root/IntroScene/ColorRect/EnemyLayer")
	if !is_enemy_bullet and collided_object.get_parent() == enemy:
		var anim_sprite = collided_object.get_child(2)
		anim_sprite.play("death")
		queue_free()		# free bullet from scene

# character collision with bullet 
func _on_body_entered(body: Node2D) -> void:
	var player = get_node("/root/IntroScene/ColorRect/IntroPlayer")
	if is_enemy_bullet and body == player:
		var anim_sprite = body.get_child(1)
		anim_sprite.play("death")
