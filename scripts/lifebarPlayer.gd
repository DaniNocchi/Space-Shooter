extends TextureProgressBar
var lifeHere = 3.0
@onready var player = $"../Player"
func _process(delta):
	global_position = player.global_position + Vector2(-14, -12)
	lifeHere = lerp(lifeHere, float(player.life), 0.1)
	value = lifeHere
