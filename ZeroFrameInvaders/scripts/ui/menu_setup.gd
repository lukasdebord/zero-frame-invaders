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
	update_target_position(start_ctrl)
	IntroPlayer.visible = true
	
	# Player ship menu animation
	if IntroPlayer.has_node("Area2D/AnimatedSprite2D"):
		var anim = IntroPlayer.get_node("Area2D/AnimatedSprite2D")
		anim.play("menu")

# Setup all button child nodes in array given
func setup_controls(controls: Array):
	for ctrl in controls:
		if ctrl is Control:
			ctrl.connect("focus_entered", Callable(self, "_on_focus_entered").bind(ctrl))
		if ctrl is HSlider:
			ctrl.connect("value_changed", Callable(self, "_on_value_changed").bind(ctrl))


func _on_focus_entered(ctrl: Control):
	update_target_position(ctrl)
func _on_value_changed(ctrl: Control):
	update_target_position(ctrl)

# Move ship to focused button
func update_target_position(ctrl: Control):
	var target_pos = Vector2.ZERO
	if ctrl is Button:
		target_pos = ctrl.global_position + Vector2(ctrl.size.x / 2, ctrl.size.y + 10)
	if ctrl is HSlider:
		var slider_width = ctrl.size.x
		var slider_range = ctrl.max_value - ctrl.min_value
		target_pos = ctrl.global_position + Vector2((ctrl.value - ctrl.min_value) / slider_range * slider_width, ctrl.size.y + 5)
		print("this runs")
	IntroPlayer.global_position = target_pos
