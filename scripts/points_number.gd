extends RichTextLabel
var points = 1; #the meteor that spawns the numbers will change this
var timer = Timer.new()
var alpha = 1
var timeAlive = 3
var canFadeOut = false
var speed = 0.5
func _ready():
	timer.one_shot = true
	add_child(timer)  # precisa estar na árvore para funcionar
	timer.timeout.connect(Callable(self, "_Cooldown_Timeout"))
	timer.start(timeAlive)


func _process(delta):
	if canFadeOut:
		alpha-=0.02
	if alpha<= 0:
		owner.queue_free()
	
	text = "[wave amp=20.0 freq=7.0 connected=1][rainbow freq=1.0 sat=0.7 val=1 speed=1.0]+"+str(points)+"[/rainbow][/wave]"
	modulate.a = alpha
	position.y -= speed
	
func _Cooldown_Timeout():
	canFadeOut = true
	
