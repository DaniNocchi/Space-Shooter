extends CharacterBody2D

@onready var speedInc = 0.015             # How much fast the player will increase its speed
@onready var maxSpeed = 2.0               # Max speed the player can get
@onready var vspd = 0                     # vertical speed
@onready var hspd = 0                     # horizontal speed
@onready var shootBool = true             # shoot boolean, it says if we can or not shoot
@onready var shootCooldown = 0.2          # the time it will take to end the cooldown for shooting
@onready var shootTimer = Timer.new()     # creating the timer for the shooting cooldown
@onready var damageTimer = Timer.new()    # Creating the timer for the damage cooldown
@onready var deadTimer = Timer.new()    # Creating the timer for the dead action
@onready var camera = $"../Camera2D"      # selecting who the hell is the game camera
@onready var debugNode = $"../../DebugMode"
@onready var life = 3                     # the player life
@onready var canTakeDamage = true         # bool that says if the player can take damage
@onready var canMoveAndRotate = true      # bool that says if the player can take damage
@onready var canShoot = true              # bool that says if the player can take damage
@onready var spriteX = 1.0                # Setting the default spriteX (used in the squatch and stretch effect)
@onready var spriteY = 1.0                # Setting the default spriteY (used in the squatch and stretch effect)
@onready var deadZone = 0.2               # Joystick deadzone
@onready var knockbackSpeed = 0.0         # The knockback speed (for when shooting)
@onready var bodiesInside = []            # Lists of bodies inside (to fix a bug: When the player took damage and 
										  # the cooldown ended, if the player is still inside the meteor, it will 
										  # not take damage again, cause the body_entered signal only checks once 
										  # if it entered only)


func _ready(): #Basically the create event
	shootTimer.one_shot = true  #Making both timers one shot (it will play and not loop when it ends)
	damageTimer.one_shot = true
	deadTimer.one_shot = true
	add_child(damageTimer)  #Adding the timers as a child (it needs to be a child so it works)
	add_child(shootTimer)
	add_child(deadTimer)
	shootTimer.timeout.connect(Callable(self, "_Shoot_Cooldown_Timeout"))    #Assigning the function the timer will call when it finishes
	damageTimer.timeout.connect(Callable(self, "_Damage_Cooldown_Timeout"))
	deadTimer.timeout.connect(Callable(self, "_Dead_Cooldown_Timeout"))

func _process(_delta): # step event
	if canMoveAndRotate: MoveAndRotate()
	else:
		hspd = lerpf(hspd, 0, speedInc)
		vspd = lerpf(vspd, 0, speedInc)
	
	if pwrupController.plusLife: 
		life+=1
		pwrupController.plusLife = false
	ShootBullets()
	spriteStretch()
	damageProcess()

# Player Features
func MoveAndRotate(): #the name says it all
	if debugNode.canChangePlayerMaxSpeed:
		maxSpeed = debugNode.playerMaxSpeed
	
	
	
	if debugNode.noPlayerSlide:
		if controller.gamepad:
			hspd = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)*maxSpeed
			vspd = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)*maxSpeed
		else:
			hspd = lerpf(hspd, Input.get_joy_axis(0, JOY_AXIS_LEFT_X)*maxSpeed, speedInc)
			vspd = lerpf(vspd, Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)*maxSpeed, speedInc)
	else:
		if debugNode.noPlayerSlide:
			hspd = (float(Input.is_action_pressed("right")) - float(Input.is_action_pressed("left"))) * maxSpeed
			vspd = (float(Input.is_action_pressed("down")) - float(Input.is_action_pressed("up"))) * maxSpeed
		else:
			hspd = lerpf(hspd, (float(Input.is_action_pressed("right")) - float(Input.is_action_pressed("left"))) * maxSpeed, speedInc)
			vspd = lerpf(vspd, (float(Input.is_action_pressed("down")) - float(Input.is_action_pressed("up"))) * maxSpeed, speedInc)
		#
	hspd = clamp(hspd, -maxSpeed, maxSpeed)
	vspd = clamp(vspd, -maxSpeed, maxSpeed)
	var oldX = global_position.x
	var oldY = global_position.y
	if global_position.x != oldX: #if touched the wall, stop trying to walk to it
		hspd = 0
	if global_position.y != oldY:
		vspd = 0
	if controller.gamepad:
		var rightJoystick = Input.get_vector("lookLeft", "lookRight", "lookUp", "lookDown", deadZone)
		if rightJoystick != Vector2.ZERO:
			rotation = rightJoystick.angle()
	else:
		look_at(get_global_mouse_position())
	global_position.x = clamp(global_position.x, 0, 320) #Limiting where you can go
	global_position.y = clamp(global_position.y, 0, 180)
	global_position.x += hspd #Making the hspd/vspd actually affect the position
	global_position.y += vspd
	if !debugNode.noPlayerKnockback:
		knockbackSpeed = lerp(knockbackSpeed, 0.0, 0.05)
		position -= transform.x * knockbackSpeed
func ShootBullets(): #the name says it all
	if pwrupController.fastShots: shootCooldown = 0.1
	else: shootCooldown = 0.2
	if canShoot:
		if Input.is_action_pressed("shoot") and shootBool:
			spriteY = 0.8
			spriteX = 1.3
			knockbackSpeed = 0.15
			$"../shootAudio".play()
			var bullet = load("res://scenes/objects/bullet.scn").instantiate()
			$"../bullets".add_child(bullet)
			bullet.transform = $Muzzle.global_transform
			shootTimer.start(shootCooldown)
			camera.add_trauma(0.2)
			if controller.gamepad and controller.gamepadShake:
				Input.start_joy_vibration(0, 0.1, 0.1, 0.1)
			shootBool = false
func spriteStretch(): #squatch and stretch when shooting
	spriteX = lerp(spriteX, 1.0, 0.3)
	spriteY = lerp(spriteY, 1.0, 0.3)
	var spriteVector = Vector2(spriteX, spriteY)
	$Sprite.scale = spriteVector
func damage(): #take damage
	if canTakeDamage and !debugNode.noPlayerDamage:
		life -=1
		$"../playerDamageAudio".play()
		canTakeDamage = false
		damageTimer.start(5)
		var animDamage = $Sprite/AnimationPlayer #spawn blinking animation
		animDamage.stop()
		animDamage.play("damage")
		camera.add_trauma(0.5)
		if controller.gamepad and controller.gamepadShake:
				Input.start_joy_vibration(0, 0.5, 0.8, 0.7)
		var partDamage = load("res://scenes/objects/playerDebris.tscn").instantiate()
		partDamage.position = global_position
		$"..".add_child(partDamage)
		if life<=0:
			controller.newPersonalRecord()
			deadTimer.start(3)

func damageProcess():
	for body in bodiesInside:
		if not is_instance_valid(body):
			bodiesInside.erase(body)
		if not body.is_in_group("meteors"):
			bodiesInside.erase(body)

			
	if bodiesInside.size() != 0:
		damage()
	if life<=0:
		canMoveAndRotate = false
		canShoot = false
	

#region Signals and Timeouts events
func _Damage_Cooldown_Timeout(): 
	canTakeDamage = true
func _Shoot_Cooldown_Timeout(): 
	shootBool = true
func _Dead_Cooldown_Timeout(): 
	Transition.change_scene("res://scenes/rooms/gameover.tscn")
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("meteors"):
		bodiesInside.append(area)
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("meteors"):
		bodiesInside.erase(area)
#endregion
