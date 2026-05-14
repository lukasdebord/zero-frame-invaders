extends Label

# update score
func _process(_delta: float) -> void:
	text = "SCORE: " + str(Globals.player_score).pad_zeros(6)
