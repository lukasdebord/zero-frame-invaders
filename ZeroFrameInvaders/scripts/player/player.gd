extends CharacterBody2D


func handle_player_movement(delta: float) -> void:
	if Input.is_action_pressed("Move_Left"):


func _physics_process(delta: float) -> void:
	handle_player_movement(delta)
	
