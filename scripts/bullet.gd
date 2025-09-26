extends Area2D
var Speed = 2.5
func _ready() -> void:
	add_to_group("bullets")
	
func _process(_delta):
	position += transform.x * Speed
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("meteors"):
		body.damage()
		queue_free() # apaga a bala
