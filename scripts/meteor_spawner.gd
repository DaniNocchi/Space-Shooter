extends Node2D
@onready var canSpawn = true
@onready var meteorTypeArray = [1, 1, 1, 2, 2, 3]
@onready var meteorType = 0
@onready var meteorAlive = 0
@onready var maxMeteor = 10
@onready var meteorTimer = Timer.new()
@onready var meteorCooldown = 0.2
@onready var Muzzle = $MuzzleMeteor1
@onready var muzzleArray = [$MuzzleMeteor1, $MuzzleMeteor2, $MuzzleMeteor3, $MuzzleMeteor4, $MuzzleMeteor5, $MuzzleMeteor6, $MuzzleMeteor7, $MuzzleMeteor8]

func _ready():
	meteorTimer.one_shot = true
	add_child(meteorTimer)  # precisa estar na árvore para funcionar
	meteorTimer.timeout.connect(Callable(self, "_Spawn_Cooldown_Timeout"))


func _process(_delta):
	meteorAlive = controller.meteorAlive
	maxMeteor = controller.MaxMeteor
	if canSpawn and meteorAlive < maxMeteor:
		meteorType = meteorTypeArray.pick_random()
		Muzzle = muzzleArray.pick_random()
		meteorTimer.start(meteorCooldown)
		canSpawn = false
		
		match meteorType:
			1:
				var meteor = load("res://scenes/objects/bullet.scn").instantiate()
				owner.add_child(meteor)
				meteor.transform = Muzzle.global_transform
				meteor.add_to_group("meteors")
				controller.meteorAlive += 1
				
			2:
				var meteor = load("res://scenes/objects/bullet.scn").instantiate()
				owner.add_child(meteor)
				meteor.transform = Muzzle.global_transform
				meteor.add_to_group("meteors")
				controller.meteorAlive += 1
			3:
				var meteor = load("res://scenes/objects/bullet.scn").instantiate()
				owner.add_child(meteor)
				meteor.transform = Muzzle.global_transform
				meteor.add_to_group("meteors")
				controller.meteorAlive += 1

func _Spawn_Cooldown_Timeout():
	canSpawn = true
