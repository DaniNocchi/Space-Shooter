extends CharacterBody2D
var speed = 0.015
var maxSpeed = 3
var vspd = 0
var hspd = 0

func _process(_delta):
	#region movement
	hspd = lerpf(hspd, (int(Input.is_action_pressed("right"))-int(Input.is_action_pressed("left")))*maxSpeed, speed)
	vspd = lerpf(vspd, (int(Input.is_action_pressed("down"))-int(Input.is_action_pressed("up")))*maxSpeed, speed)
	
	hspd = clamp(hspd, -maxSpeed, maxSpeed)
	vspd = clamp(vspd, -maxSpeed, maxSpeed)

	var oldX = global_position.x
	var oldY = global_position.y

	global_position.x = clamp(global_position.x, 0, 320)
	global_position.y = clamp(global_position.y, 0, 180)

	if global_position.x != oldX:
		hspd = 0
	if global_position.y != oldY:
		vspd = 0
		
	global_position.x += hspd
	global_position.y += vspd
	#endregion
	#region rotation
	look_at(get_global_mouse_position())
	#endregion
	
