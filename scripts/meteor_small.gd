extends RigidBody2D
var rng = RandomNumberGenerator.new()
var spriteList = ["res://Sprites/smallMeteor/small1.png","res://Sprites/smallMeteor/small2.png","res://Sprites/smallMeteor/small3.png","res://Sprites/smallMeteor/small4.png"]
var sprite = rng.randi_range(0, 3) 
var speed = 0.0
var life = 1
var pointsGiven = 1
@onready var damageAnim: AnimationPlayer = $Sprite2D/AnimationPlayer

func _ready():
	add_to_group("meteors")
	speed = rng.randf_range(1.0, 1.6)
	var texture = load(spriteList[sprite])
	$Sprite2D.texture = texture
func _process(delta: float) -> void:
	position += transform.x * speed
	$Sprite2D.rotation += speed/15
	
func damage():
	life -=1
	var damageParticle = load("res://scenes/objects/meteorDebris.tscn").instantiate()
	damageParticle.position = global_position
	$"..".add_child(damageParticle)
	if life <= 0:
		controller.Points+=pointsGiven
		controller.meteorAlive-=1
		$CollisionShape2D.queue_free()
		$Area2D.queue_free()
		damageAnim.play("die")
		remove_from_group("meteors")
		pointsText(pointsGiven)
	else:
		damageAnim.stop()
		damageAnim.play("flash")
func pointsText(_points):
	var _pointsText = load("res://scenes/objects/PointsNumber.tscn").instantiate()
	var _textObject = _pointsText.get_node("actualObject")
	_textObject.points = _points
	$"..".add_child(_pointsText)
	_pointsText.position = global_position
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		queue_free()
	
