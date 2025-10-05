extends Node2D
var pressedTimer = Timer.new()
var pressing = false
var timerActive = false
@onready var skipText = $CanvasLayer/Label
@onready var skipProgress = $CanvasLayer/TextureProgressBar
func _ready():
	pressedTimer.one_shot = true
	add_child(pressedTimer)
	pressedTimer.timeout.connect(Callable(self, "_Pressed_Cooldown_Timeout")) 
	
	
	
func _process(delta):
	if Input.is_anything_pressed():
		pressing = true
	else:
		pressing = false
		
	if $AnimationPlayer.current_animation == "credits":
		if pressing == true:
			if timerActive == false:
				timerActive = true
				pressedTimer.start(3)
			skipText.modulate = lerp(skipText.modulate, Color(1, 1, 1, 1), 0.1)
			skipProgress.modulate = lerp(skipProgress.modulate, Color(1, 1, 1, 1), 0.1)
			skipProgress.value = round(pressedTimer.time_left*100)/100
		else:
			skipText.modulate = Color(1, 1, 1, 0)
			skipProgress.modulate = Color(1, 1, 1, 0)
			pressedTimer.stop()
			timerActive = false
	else:
		skipText.modulate = Color(1, 1, 1, 0)
		skipProgress.modulate = Color(1, 1, 1, 0)


func _Pressed_Cooldown_Timeout():
	if pressing == true:
		timerActive = false
		$AnimationPlayer.play("end")
