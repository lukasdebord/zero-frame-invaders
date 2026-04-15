extends Area2D

const SPEED = 250
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


func _on_collision(collided_object: Area2D) -> void:
	if !is_enemy_bullet and collided_object.get_parent() == get_node("/root/IntroScene/ColorRect/EnemyLayer"):
		var anim_sprite = collided_object.get_child(2)
		anim_sprite.play("death")
		queue_free()
		collided_object.queue_free()
	if is_enemy_bullet and collided_object.get_parent() == get_node("/root/IntroScene/ColorRect/IntroPlayer"):
		var anim_sprite = collided_object.get_child(1)
		anim_sprite.play("death")
