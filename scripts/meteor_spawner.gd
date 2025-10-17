extends Node2D
@onready var canSpawn = true
@onready var meteorTypeList = [1, 1, 1, 2, 2, 3] #1: small, 2: medium, 3: big
@onready var meteorAlive = 0
@onready var maxMeteor = 10
@onready var meteorTimer = Timer.new()
@onready var meteorCooldown = 0.05
@onready var Muzzle = $MuzzleMeteor1
@onready var locationList = [$MuzzleMeteor1, $MuzzleMeteor2, $MuzzleMeteor3, $MuzzleMeteor4, $MuzzleMeteor5, $MuzzleMeteor6, $MuzzleMeteor7, $MuzzleMeteor8]

func _ready():
	meteorTimer.one_shot = true
	add_child(meteorTimer)  # precisa estar na árvore para funcionar
	meteorTimer.timeout.connect(Callable(self, "_Spawn_Cooldown_Timeout"))


func _process(_delta):
	if canSpawn and controller.meteorAlive < controller.MaxMeteor:
		var meteorType = meteorTypeList.pick_random();
		Muzzle = locationList.pick_random()
		meteorTimer.start(meteorCooldown)
		var meteor = load("res://scenes/objects/meteor.tscn").instantiate()
		meteor.type = meteorType
		$"..".add_child(meteor)
		meteor.transform = Muzzle.global_transform
		meteor.damageAudioPlayer = $"../meteorDamageAudio"; 
		meteor.dieAudioPlayer = $"../meteorDieAudio"
		controller.meteorAlive += 1
		canSpawn = false

func _Spawn_Cooldown_Timeout(): 
	canSpawn = true
