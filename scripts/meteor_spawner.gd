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
		var spawnPlace = randi_range(0, 1)
		var locationX : int
		var locationY : int
		if spawnPlace == 1: #0 = Horizontal spawn, it will spawn or on the bottom or on the top of the scene
			locationX = randi_range(-16, 336)
			locationY = [-16, 196].pick_random()
		else:				#1 = vertical spawn, it will spawn or on the left or on the right of the scene
			locationX = [-16, 336].pick_random()
			locationY = randi_range(-16, 196)
		
		meteorTimer.start(meteorCooldown)
		var meteor : Area2D = load("res://scenes/objects/meteor.tscn").instantiate()
		meteor.type = meteorType
		$"../meteors".add_child(meteor)
		meteor.position = Vector2(locationX, locationY)
		meteor.rotation = randi_range(0, 360)
		meteor.damageAudioPlayer = $"../meteorDamageAudio"; 
		meteor.dieAudioPlayer = $"../meteorDieAudio"
		controller.meteorAlive += 1
		canSpawn = false

func _Spawn_Cooldown_Timeout(): 
	canSpawn = true
