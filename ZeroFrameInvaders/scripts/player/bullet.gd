extends Area2D

@onready var enemy_layer = get_tree().get_first_node_in_group("enemy_layer")
@onready var player = get_node("/root/IntroScene/ColorRect/IntroPlayer")

const SPEED = 175
var direction = Vector2.ZERO
var is_enemy_bullet = true


func _ready():
	add_to_group("bullets")
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
func _on_collision(enemy: Node) -> void:
	if !is_enemy_bullet and enemy.get_parent() == enemy_layer:
		var anim_sprite = enemy.get_child(2)
		var collision_box = enemy.get_child(0)
		collision_box.set_deferred("disabled", true)		# disable collision for future bullets
		queue_free()		# free bullet from scene
		Globals.add_score(enemy.score_value)
		anim_sprite.play("death")


# character collision with bullet 
func _on_body_entered(body: Node2D) -> void:
	if is_enemy_bullet and body == player:
		var anim_sprite = body.get_child(1)
		player.can_control = false		# disable player movement during animation
		enemy_layer.can_move = false		# disable enemy movement during animation
		enemy_layer.enemy_timer.paused = true
		
		# clear all bullets from screen
		var bullets = get_tree().get_nodes_in_group("bullets")
		for bullet in bullets:
			bullet.queue_free()
		
		# play death animation
		anim_sprite.play("death")
