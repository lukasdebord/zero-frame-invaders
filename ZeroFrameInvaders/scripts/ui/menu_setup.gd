extends Node

var IntroPlayer: Node2D = null

const INTRO_PLAYER_SCENE := preload("res://scenes/player/IntroPlayer.tscn")



# Instantiate IntroPlayer into scene
func load_intro_player(parent: Node, start_ctrl: Control):
	if IntroPlayer and IntroPlayer.is_inside_tree():
		# Player ship menu animation
		if IntroPlayer.has_node("AnimatedSprite2D"):
			IntroPlayer.anim_sprite.play("menu")
		return  # Already added

	# Instantiate intro player ship
	IntroPlayer = INTRO_PLAYER_SCENE.instantiate()
	parent.add_child(IntroPlayer)
	
	await get_tree().process_frame # Allow a frame for UI to update
	
	# Set starting position of ship
	update_target_position(start_ctrl)
	IntroPlayer.visible = true
	
	# Player ship menu animation
	if IntroPlayer.has_node("AnimatedSprite2D"):
		IntroPlayer.anim_sprite.play("menu")


# Setup all button child nodes in array given
func setup_controls(controls: Array):
	for ctrl in controls:
		if !(ctrl.is_connected("focus_entered", Callable(self, "_on_focus_entered"))):
			if ctrl is Control:
				ctrl.connect("focus_entered", Callable(self, "_on_focus_entered").bind(ctrl))
			if ctrl is Slider:
				ctrl.connect("value_changed", Callable(self, "_on_value_changed").bind(ctrl))


# Run on Control focused
func _on_focus_entered(ctrl: Control):
	update_target_position(ctrl)
# Run on slider value changed
func _on_value_changed(_value: float, ctrl: Control):
	update_target_position(ctrl)


# Move ship to focused item
func update_target_position(ctrl: Control):
	var target_pos = Vector2.ZERO
	
	# Move ship to button
	if ctrl is Button:
		target_pos = ctrl.global_position + Vector2(ctrl.size.x / 2, ctrl.size.y + 10)
	# Follow slider grabber
	if ctrl is Slider:
		var slider_width = ctrl.size.x - 16 	# Offset slider width to account for grabber width
		var slider_range = (ctrl.max_value - ctrl.min_value)
		var normalized_pos = Vector2(ctrl.global_position.x + 8, ctrl.global_position.y) 	# Offset by half grabber width
		target_pos = normalized_pos + Vector2((ctrl.value) / slider_range * slider_width, ctrl.size.y + 5)
	IntroPlayer.global_position = target_pos
