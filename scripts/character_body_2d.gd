extends CharacterBody2D

@onready var speedInc = 0.015             # How much fast the player will increase its speed
@onready var maxSpeed = 3                 # Max speed the player can get
@onready var vspd = 0                     # vertical speed
@onready var hspd = 0                     # horizontal speed
@onready var shootBool = true             # shoot boolean, it says if we can or not shoot
@onready var shootCooldown = 0.2          # the time it will take to end the cooldown for shooting
@onready var shootTimer = Timer.new()     # creating the timer for the shooting cooldown

func _ready():
	shootTimer.one_shot = true
	add_child(shootTimer)  # precisa estar na árvore para funcionar
	shootTimer.timeout.connect(Callable(self, "_Shoot_Cooldown_Timeout"))

func _process(_delta): # step event
	MoveAndRotate()
	ShootBullets()

# Player Features
func MoveAndRotate():
	hspd = lerpf(hspd, (int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))) * maxSpeed, speedInc)
	vspd = lerpf(vspd, (int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))) * maxSpeed, speedInc)
	
	hspd = clamp(hspd, -maxSpeed, maxSpeed)
	vspd = clamp(vspd, -maxSpeed, maxSpeed)

	var oldX = global_position.x
	var oldY = global_position.y

	global_position.x = clamp(global_position.x, 0, 320)
	global_position.y = clamp(global_position.y, 0, 180)

	if global_position.x != oldX:
		hspd = 0
	if global_position.y != oldY:
		vspd = 0
		
	global_position.x += hspd
	global_position.y += vspd
	
	look_at(get_global_mouse_position())
func ShootBullets():
	if Input.is_action_pressed("shoot") and shootBool:
		var bullet = load("res://scenes/objects/bullet.scn").instantiate()
		owner.add_child(bullet)
		bullet.add_to_group("bullets")
		bullet.transform = $Muzzle.global_transform
		shootTimer.start(shootCooldown)
		shootBool = false
		
func _Shoot_Cooldown_Timeout():
	shootBool = true
