extends Node

var IntroPlayer: Node2D = null

const INTRO_PLAYER_SCENE := preload("res://scenes/player/IntroPlayer.tscn")

# 
func load_intro_player(parent: Node, start_ctrl: Control):
	if IntroPlayer and IntroPlayer.is_inside_tree():
		return  # Already added

	# Instantiate intro player ship
	IntroPlayer = INTRO_PLAYER_SCENE.instantiate()
	parent.add_child(IntroPlayer)
	
	await get_tree().process_frame # Allow a frame for UI to update
	
	# Set starting position of ship
	var target_pos = 0
	if start_ctrl is Button:
		target_pos = start_ctrl.global_position + Vector2(start_ctrl.size.x / 2, start_ctrl.size.y + 10)
	if start_ctrl is HSlider:
		target_pos = start_ctrl.global_position + Vector2(start_ctrl.value / 2, start_ctrl.size.y + 5)
	IntroPlayer.global_position = target_pos
	IntroPlayer.visible = true
	
	# Player ship menu animation
	if IntroPlayer.has_node("Area2D/AnimatedSprite2D"):
		var anim = IntroPlayer.get_node("Area2D/AnimatedSprite2D")
		anim.play("menu")

# Setup all button child nodes in array given
func setup_controls(controls: Array):
	for ctrl in controls:
		if ctrl is Control:
			ctrl.connect("focus_entered", Callable(self, "_on_control_focus").bind(ctrl))

# Move ship to focused button
func _on_control_focus(ctrl: Control):
	var target_pos = 0
	if ctrl is Button:
		target_pos = ctrl.global_position + Vector2(ctrl.size.x / 2, ctrl.size.y + 10)
	if ctrl is HSlider:
		target_pos = ctrl.global_position + Vector2(ctrl.value / 2, ctrl.size.y + 5)
	IntroPlayer.global_position = target_pos
