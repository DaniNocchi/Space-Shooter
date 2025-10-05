extends RigidBody2D
var rng = RandomNumberGenerator.new()
var spriteList = ["res://Sprites/bigMeteor/big1.png","res://Sprites/bigMeteor/big2.png","res://Sprites/bigMeteor/big3.png"]
var speed = 0.0
var life = 3
var pointsGiven = 3
@export var damageAudioPlayer : AudioStreamPlayer
@export var dieAudioPlayer : AudioStreamPlayer
@onready var damageAnim: AnimationPlayer = $Sprite2D/AnimationPlayer

func _ready():
	add_to_group("meteors")
	speed = rng.randf_range(0.5, 1.2)
func _process(delta: float) -> void:
	position += transform.x * speed
	$Sprite2D.rotation += speed/15
	spriteChange()

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
		dieAudioPlayer.play()
		remove_from_group("meteors")
		pointsText(pointsGiven)
	else:
		damageAnim.stop()
		damageAudioPlayer.play()
		damageAnim.play("flash")

func spriteChange():
	match life:
		3:
			var texture = load(spriteList[0])
			$Sprite2D.texture = texture
		2:
			var texture = load(spriteList[1])
			$Sprite2D.texture = texture
		1:
			var texture = load(spriteList[2])
			$Sprite2D.texture = texture
		_:
			var texture = load(spriteList[2])
			$Sprite2D.texture = texture
func pointsText(_points):
	var _pointsText = load("res://scenes/objects/PointsNumber.tscn").instantiate()
	var _textObject = _pointsText.get_node("actualObject")
	_textObject.points = _points
	$"..".add_child(_pointsText)
	_pointsText.position = global_position
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		queue_free()
	
