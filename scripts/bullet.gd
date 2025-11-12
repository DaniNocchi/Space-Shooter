extends Area2D
var Speed = 2.5
@onready var line = $line
func _ready() -> void:
	add_to_group("bullets")
	controller.bulletsShot += 1
	
func _process(_delta):
	position += transform.x * Speed
	if pwrupController.aimbot:
		var meteor = get_closest_meteor()
		if meteor:
			var distance = meteor.global_position.distance_to(global_position)
			if distance < 25:
				var local_to_meteor = (to_local(meteor.global_position))
				line.points = [Vector2.ZERO, local_to_meteor]
				var direction_vector = (meteor.global_position - global_position).normalized()
				var angle_to_meteor = direction_vector.angle()  # já em radianos
				rotation = lerp_angle(rotation, angle_to_meteor, 0.1)
			else: line.points[1] = Vector2(0,0)
	else: line.points[1] = Vector2(0,0)



func get_closest_meteor():
	var meteors = get_tree().get_nodes_in_group("meteors")
	var closest_meteor = null
	var closest_distance = INF

	for meteor in meteors:
		var distance = meteor.global_position.distance_squared_to(global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_meteor = meteor
	return closest_meteor
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("meteors"):
		area.damage()
		queue_free() # apaga a bala
