extends RigidBody2D
var spriteList = ["res://Sprites/smallMeteor/small3.png","res://Sprites/smallMeteor/small4.png","res://Sprites/smallMeteor/small1.png","res://Sprites/smallMeteor/small2.png",]
var speed = 0
var speedList = [1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2]
func _ready():
	add_to_group("meteors")
	speed = speedList.pick_random()
	var texture = load(spriteList.pick_random())
	$Sprite2D.texture = texture
	
func _process(delta: float) -> void:
	position += transform.x * speed
	$Sprite2D.rotation += speed/15
	

	
	
