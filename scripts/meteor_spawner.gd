extends Node2D
@onready var canSpawn = true
@onready var meteorTypeArray = [1, 1, 1, 2, 2, 3] #1: small, 2: medium, 3: big
@onready var meteorType = 0 					  #1: 50%;   2: 33%;    3:16%
@onready var meteorAlive = 0
@onready var maxMeteor = 10
@onready var meteorTimer = Timer.new()
@onready var meteorCooldown = 0.05
@onready var Muzzle = $MuzzleMeteor1
@onready var muzzleArray = [$MuzzleMeteor1, $MuzzleMeteor2, $MuzzleMeteor3, $MuzzleMeteor4, $MuzzleMeteor5, $MuzzleMeteor6, $MuzzleMeteor7, $MuzzleMeteor8]

func _ready():
	meteorTimer.one_shot = true
	add_child(meteorTimer)  # precisa estar na árvore para funcionar
	meteorTimer.timeout.connect(Callable(self, "_Spawn_Cooldown_Timeout"))


func _process(_delta):
	if canSpawn and controller.meteorAlive < controller.MaxMeteor:
		meteorType = meteorTypeArray.pick_random(); Muzzle = muzzleArray.pick_random()
		meteorTimer.start(meteorCooldown)
		var _meteor : RigidBody2D
		match meteorType:
			1: _meteor = load("res://scenes/objects/meteorSmall.tscn").instantiate()
			2: _meteor = load("res://scenes/objects/meteorMedium.tscn").instantiate()
			3: _meteor = load("res://scenes/objects/meteorBig.tscn").instantiate()
		$"..".add_child(_meteor)
		_meteor.transform = Muzzle.global_transform
		_meteor.damageAudioPlayer = $"../meteorDamageAudio"; _meteor.dieAudioPlayer = $"../meteorDieAudio"
		controller.meteorAlive += 1
		canSpawn = false

func _Spawn_Cooldown_Timeout(): 
	canSpawn = true
