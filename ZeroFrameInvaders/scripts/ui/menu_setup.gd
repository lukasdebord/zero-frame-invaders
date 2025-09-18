extends Node

var IntroPlayer: Node2D = null

const INTRO_PLAYER_SCENE := preload("res://scenes/player/IntroPlayer.tscn")

func load_intro_player(parent: Node, position := Vector2.ZERO):
	if IntroPlayer and IntroPlayer.is_inside_tree():
		return  # Already added

	IntroPlayer = INTRO_PLAYER_SCENE.instantiate()
	parent.add_child(IntroPlayer)
	IntroPlayer.global_position = position
	IntroPlayer.visible = false

# Define ship and play menu animation
func register_ship():
	IntroPlayer.visible = true
	IntroPlayer
	if IntroPlayer.has_node("Area2D/AnimatedSprite2D"):
		var anim = IntroPlayer.get_node("Area2D/AnimatedSprite2D")
		anim.play("menu")

# Setup all button child nodes in array given
func setup_buttons(buttons: Array):
	for btn in buttons:
		if btn is Button:
			btn.connect("focus_entered", Callable(self, "_on_button_focus").bind(btn))

# Move ship to focused button
func _on_button_focus(btn: Button):
	var target_pos = btn.global_position + Vector2(btn.size.x / 2, btn.size.y + 10)
	IntroPlayer.global_position = target_pos
