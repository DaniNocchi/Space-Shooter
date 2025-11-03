extends TextureProgressBar
var sprite : Texture2D
var timer = Timer.new()
var timerTime : float
var power : int
func _ready():
	timerTime = pwrupController.pullTimerTime(power)
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
	pwrupController.timerTimeout(power)
	
	pwrupController.usingPowerup.erase(power)
	queue_free()
