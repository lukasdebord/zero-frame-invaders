extends Area2D

const SPEED = 250
var direction = Vector2.UP


func _ready():
	connect("area_entered", Callable(self, "_on_collision"))


func _process(delta):
	# Bullet movement
	position += direction * SPEED * delta
	
	# Remove bullet if offscreen
	if not get_viewport_rect().has_point(global_position):
		queue_free()


func _on_collision(collided_enemy: Area2D) -> void:
	var anim_sprite = collided_enemy.get_child(2)
	if collided_enemy.get_parent() == get_node("/root/IntroScene/ColorRect/EnemyLayer"):
		anim_sprite.play("death")
		queue_free()
		collided_enemy.queue_free()
