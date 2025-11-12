extends Node2D
var pressedTimer = Timer.new()
var pressing = false
var timerActive = false
@onready var skipText = $CanvasLayer/skippingText
@onready var skipProgress = $CanvasLayer/skippingProgress
@onready var animation = $animation
var alpha0 = Color(1,1,1,0)
var alpha1 = Color(1,1,1,1)
func _ready():
	pressedTimer.one_shot = true
	add_child(pressedTimer)
	pressedTimer.timeout.connect(Callable(self, "_Pressed_Cooldown_Timeout")) 
	
	
	
func _process(delta):
	pressing = Input.is_anything_pressed()
	if animation.current_animation == "credits":
		if pressing:
			if timerActive == false:
				timerActive = true
				pressedTimer.start(2)
			skipText.modulate = lerp(skipText.modulate, alpha1, 0.1)
			skipProgress.tint_progress = alpha1
			skipProgress.tint_under = lerp(skipProgress.tint_under, alpha1,0.1)
			skipProgress.value = round(pressedTimer.time_left*100)/100
		else: #if not pressing
			skipText.modulate = alpha0
			skipProgress.tint_under = alpha0
			skipProgress.tint_progress = alpha0
			pressedTimer.stop()
			timerActive = false
	else: #if not even playing the animation at all
		skipText.modulate = alpha0
		skipProgress.tint_under =alpha0
		skipProgress.tint_progress = alpha0


func _Pressed_Cooldown_Timeout():
	if pressing == true:
		timerActive = false
		animation.play("end")
