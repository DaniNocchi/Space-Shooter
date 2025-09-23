extends RigidBody2D
var Speed = 2.5
func _ready() -> void:
	add_to_group("bullets")
	
func _process(_delta):
	position += transform.x * Speed
	
