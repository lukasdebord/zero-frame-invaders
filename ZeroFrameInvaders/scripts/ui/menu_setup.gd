extends Node

var ship: Node2D = null

func register_ship(_ship: Node2D):
	ship = _ship
	ship.visible = true
	ship.anim

func setup_buttons(buttons: Array):
	for btn in buttons:
		if btn is Button:
			btn.connect("focus_entered", Callable(self, "_on_button_focus").bind(btn))

# Move ship to focused button
func _on_button_focus(btn: Button):
	var target_pos = btn.global_position + Vector2(btn.size.x / 2, btn.size.y + 10)
	ship.global_position = target_pos
