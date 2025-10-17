extends Area2D
var Speed = 2.5
func _ready() -> void:
	add_to_group("bullets")
	controller.bulletsShot += 1
	
func _process(_delta):
	position += transform.x * Speed

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("meteors"):
		area.damage()
		queue_free() # apaga a bala
