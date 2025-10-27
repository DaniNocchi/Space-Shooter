extends Area2D
var power = 0
var progressList : VBoxContainer
var spriteList = [
	"res://Sprites/power0.png",
	"res://Sprites/power1.png"
	
]

func _ready():
	$sprite.texture = load(spriteList[(power-1)])
	position = Vector2(randi_range(10, 300), randi_range(10, 170))
func spawnTimer():
	#if the player is using the powerup already, reset its timer
	if controller.usingPowerup.has(power): 
		var childrens = progressList.get_children()
		for i in range(childrens.size()):
			if childrens[i].get("power") != null and childrens[i].power == power:
				childrens[i].timer.start(childrens[i].timerTime)
	#else, if the player is not using this powerup, create the timer
	else:
		controller.usingPowerup.append(power)
		var progressBar = load("res://scenes/objects/progressbarpowerup.tscn").instantiate()
		progressBar.sprite = load(spriteList[(power-1)])
		progressBar.power = power
		progressList.add_child(progressBar)
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$AnimationPlayer.play("out")
		match power:
			1:
				controller.doublePoints = true
				spawnTimer()
			2:
				controller.fastShots = true
				spawnTimer()
		await $AnimationPlayer.animation_finished
		queue_free()
