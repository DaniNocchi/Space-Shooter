extends Area2D
var rng = RandomNumberGenerator.new()
var spriteSmall = 			["res://Sprites/smallMeteor/small1.png", "res://Sprites/smallMeteor/small2.png", "res://Sprites/smallMeteor/small3.png", "res://Sprites/smallMeteor/small4.png"]

var spriteMedium = 			["res://Sprites/mediumMeteor/medium1.png", "res://Sprites/mediumMeteor/medium2.png", "res://Sprites/mediumMeteor/medium3.png"]
var spriteMediumBroken = 	["res://Sprites/mediumMeteor/mediumBroken1.png", "res://Sprites/mediumMeteor/mediumBroken2.png", "res://Sprites/mediumMeteor/mediumBroken3.png"]

var spriteBig = 			["res://Sprites/bigMeteor/big1.png"]
var spriteBigSlightBroken = ["res://Sprites/bigMeteor/bigSlightBroken1.png"]
var spriteBigBroken = 		["res://Sprites/bigMeteor/bigBroken1.png"]

var spriteVariation = 0

var type = 1 # Meteor type (1: Small, 2: Medium, 3: Big)
var speed = 0.0 #The speed it will walk, it depends on the type and RNG
var life = 1 #The life the meteor has, it depends on the type
var pointsGiven = 1 #the points it will give, it depends on the type

var colShape = CircleShape2D.new()
@export var damageAudioPlayer : AudioStreamPlayer
@export var dieAudioPlayer : AudioStreamPlayer
@onready var damageAnim: AnimationPlayer = $sprite/animation

func _ready():
	add_to_group("meteors")
	match type:
		1: #small
			life = 1
			spriteVariation = rng.randi_range(0, 3)
			speed = rng.randf_range(0.7, 1.5)
			colShape.radius = 6
			pointsGiven = 1
			$collision.shape = colShape
		2: #medium
			life = 2
			spriteVariation = rng.randi_range(0, 2)
			speed = randf_range(0.6, 1.3)
			colShape.radius = 9
			pointsGiven = 2
			$collision.shape = colShape
		3: #big
			life = 3
			spriteVariation = 0
			speed = randf_range(0.4, 1.0)
			colShape.radius = 12
			pointsGiven = 3
			$collision.shape = colShape
	spriteChange()
func _process(delta: float) -> void:
	position += transform.x * speed
	$sprite.rotation += speed/15
	spriteChange()
func damage():
	life -=1
	var damageParticle = load("res://scenes/objects/meteorDebris.tscn").instantiate()
	damageParticle.position = global_position
	$"..".add_child(damageParticle)
	if life > 0:
		damageAnim.stop()
		damageAudioPlayer.play()
		damageAnim.play("flash")
	else:
		if controller.doublePoints: pointsGiven *= 2
		controller.Points += pointsGiven
		controller.meteorAlive -= 1
		controller.meteorKilled += 1
		damageAnim.play("die")
		dieAudioPlayer.play()
		remove_from_group("meteors")
		pointsText(pointsGiven)
func spriteChange():
	match type:
		1: #small
			$sprite.texture = load(spriteSmall[spriteVariation])
		2: #medium
			match life:
				2:
					$sprite.texture = load(spriteMedium[spriteVariation])
				1:
					$sprite.texture = load(spriteMediumBroken[spriteVariation])
				_:
					$sprite.texture = load(spriteMediumBroken[spriteVariation])
		3: #big
			match life:
				3:
					$sprite.texture = load(spriteBig[spriteVariation])
				2:
					$sprite.texture = load(spriteBigSlightBroken[spriteVariation])
				1:
					$sprite.texture = load(spriteBigBroken[spriteVariation])
				_:
					$sprite.texture = load(spriteBigBroken[spriteVariation])
func pointsText(_points):
	var _pointsText = load("res://scenes/objects/PointsNumber.tscn").instantiate()
	var _textObject = _pointsText.get_node("actualObject")
	_textObject.points = _points
	$"..".add_child(_pointsText)
	_pointsText.position = global_position
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		queue_free()
	
