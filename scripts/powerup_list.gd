extends VBoxContainer

@onready var player := $"../Player"
@onready var playerCollision := $"../Player/Collision"
@onready var selfCollision := $area/collision
@export var fade_distance := 10.0
@export var min_alpha := 0.5

func _process(_delta):
	var playerPos = player.global_position
	var selfPos = global_position
	
	#collision shapes
	var shape1 = selfCollision.shape
	var shape2 = playerCollision.shape
	
	shape1.size.y            = (max(0, controller.usingPowerup.size() - 1) * 20 + 16)
	selfCollision.position.y = (max(0, controller.usingPowerup.size() - 1) * 10 + 8)
	# considering scales
	var size1 = shape1.size
	var size2 = shape2.size * player.scale
	
	# Bordas do objeto 1 (crescendo pra baixo e direita)
	var borderLeft =   selfPos.x
	var borderRight =  selfPos.x + size1.x
	var borderTop =    selfPos.y
	var borderBottom = selfPos.y + size1.y
	
	# Bordas do player (considerando centro)
	var playerLeft =   playerPos.x - size2.x / 2.0
	var playerRight =  playerPos.x + size2.x / 2.0
	var playerTop =    playerPos.y - size2.y / 2.0
	var playerBottom = playerPos.y + size2.y / 2.0
	
	# Distância horizontal entre bordas
	var horizontalDistance = 0.0
	if playerRight < borderLeft:
		horizontalDistance = borderLeft - playerRight
	elif playerLeft > borderRight:
		horizontalDistance = playerLeft - borderRight
	else:
		horizontalDistance = 0.0  # sobreposto horizontalmente
	
	# Distância vertical entre bordas
	var verticalDistance = 0.0
	if playerBottom < borderTop:
		verticalDistance = borderTop - playerBottom
	elif playerTop > borderBottom:
		verticalDistance = playerTop - borderBottom
	else:
		verticalDistance = 0.0  # sobreposto verticalmente
	
	# Distância real entre bordas (Pitágoras)
	var borderDistance = sqrt(horizontalDistance * horizontalDistance + verticalDistance * verticalDistance)
	
	# Fade baseado nessa distância
	var alpha = clamp(1.0 - (1.0 - min_alpha) * (1.0 - borderDistance / fade_distance), min_alpha, 1.0)
	modulate.a = alpha
