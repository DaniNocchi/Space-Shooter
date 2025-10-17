extends TextureProgressBar
var sprite : Texture2D
var timer = Timer.new()
var timerTime : int
var power : int
func _ready():
	
	match power:
		1: timerTime = 10
		2: timerTime = 10
		#3:
		
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(Callable(self, "_timer_timeout"))
	texture_under = sprite
	texture_progress = sprite
	timer.start(timerTime)
	max_value = timerTime

func _process(delta: float) -> void:
	value = timer.time_left
func _timer_timeout():
	match power:
		1: controller.doublePoints = false
		2: controller.fastShots = false
		#3:
		
	controller.existingPowerup.erase(power)
	queue_free()
