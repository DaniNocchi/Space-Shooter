extends Node2D
@onready var canSpawn = true
@onready var meteorTypeList = [1, 1, 1, 2, 2, 3] #1: small, 2: medium, 3: big
@onready var meteorAlive = 0
@onready var maxMeteor = 10
@onready var meteorTimer = Timer.new()
@onready var meteorCooldown = 0.05
@onready var debugNode = $"../../DebugMode"

func _ready():
	meteorTimer.one_shot = true
	add_child(meteorTimer)  # precisa estar na árvore para funcionar
	meteorTimer.timeout.connect(Callable(self, "_Spawn_Cooldown_Timeout"))


func _process(_delta):
	if debugNode.toggleMeteorSpawn and canSpawn and controller.meteorAlive < controller.MaxMeteor:
		#picking the meteor properties randomly
		var meteorType = meteorTypeList.pick_random();
		var locationX = randi_range(-16, 336)
		var locationY = randi_range(-16, 196)
		var location = Vector2(locationX, locationY)
		meteorTimer.start(meteorCooldown)
		var meteor = load("res://scenes/objects/meteor.tscn").instantiate()
		meteor.type = meteorType
		$"..".add_child(meteor)
		meteor.transform = location.global_transform
		meteor.damageAudioPlayer = $"../meteorDamageAudio"; 
		meteor.dieAudioPlayer = $"../meteorDieAudio"
		controller.meteorAlive += 1
		canSpawn = false

func _Spawn_Cooldown_Timeout(): 
	canSpawn = true
