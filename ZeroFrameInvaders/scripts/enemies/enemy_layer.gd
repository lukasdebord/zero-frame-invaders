extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	for enemy in get_children():
		var sprite = enemy.get_node("Area2D/AnimatedSprite2D")
		sprite.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
