extends Label
func _process(delta):
	global_position = $"../Player".global_position + Vector2(-28, -20)
