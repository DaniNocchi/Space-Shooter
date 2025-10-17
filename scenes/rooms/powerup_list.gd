extends VBoxContainer

@export var player: Node2D
@export var fadeDistance := 10.0
@export var minAlpha := 0.3

func _process(delta):
	var playerPos = player.position
	var selfPos = global_position
	var selfSize = size
	
	var left   = selfPos.x
	var right  = selfPos.x + selfSize.x
	var top    = selfPos.y
	var bottom = selfPos.y + selfSize.y

	# Calcula apenas as distâncias RELEVANTES
	var leftDist  = max(0.0, left - playerPos.x)
	var rightDist = max(0.0, playerPos.x - right)
	var upDist    = max(0.0, top - playerPos.y)
	var downDist  = max(0.0, playerPos.y - bottom)

	var alpha_left  = fade(leftDist)
	var alpha_right = fade(rightDist)
	var alpha_up    = fade(upDist)
	var alpha_down  = fade(downDist)

	var alpha = min(alpha_left, alpha_right, alpha_up, alpha_down)

	modulate.a = alpha

	print("Left:", alpha_left, " Right:", alpha_right, " Up:", alpha_up, " Down:", alpha_down, " Alpha:", alpha)
func fade(dist):
		return clamp(1.0 - (dist / fadeDistance), minAlpha, 1.0)
