extends Node2D
@onready var pausable = $"../pausable"
var paused = false
@onready var animPlayer = $pauseLayer/pauseFade/AnimationPlayer

func _process(_delta):
	if Input.is_action_just_released("pause"):
		if !paused:
			paused = true
			animPlayer.play("in")
	if Input.is_action_just_released("pause") or Input.is_action_just_released("back"):
		if paused and !animPlayer.is_playing():
			if !controller.optionsEnabled:
				paused = false
				animPlayer.play("out")

# This is an UI code, ignore its stupid bad code.


func pause():
	pausable.process_mode = Node.PROCESS_MODE_DISABLED
	if !controller.gamepad: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func unpause():
	pausable.process_mode = Node.PROCESS_MODE_INHERIT
	if !controller.gamepad: Input.mouse_mode = Input.MOUSE_MODE_CONFINED
