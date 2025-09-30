extends NinePatchRect
@export var alpha = 1.0
func set_scaled_size(new_size: Vector2) -> void:
	var center = global_position + size * 0.5
	size = new_size
	global_position = center - size * 0.5
	
func _process(delta):
	set_scaled_size(Vector2($waveText.size.x, 0) + Vector2(10, 65))
	changeAlpha()
	$waveText.text = "Wave "+str(controller.Wave)
	
func changeAlpha():
	var Player = $"../../Player"
	
	
	alpha = Player.position.y/15 - 1
	alpha = clamp(alpha, 0.4, 1)
	modulate = Color(1, 1, 1, alpha)
