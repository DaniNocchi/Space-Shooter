extends Area2D
var power = 0
var progressList : VBoxContainer
func _ready():
	$sprite.texture = load(pwrupController.spriteList[(power-1)])
	position = Vector2(randi_range(10, 300), randi_range(10, 170))
func spawnTimer():
	#if the player is using the powerup already, reset its timer
	if pwrupController.usingPowerup.has(power): 
		var childrens = progressList.get_children()
		for i in range(childrens.size()):
			if childrens[i].get("power") != null and childrens[i].power == power:
				childrens[i].timer.start(childrens[i].timerTime)
	#else, if the player is not using this powerup, create the timer
	else:
		pwrupController.usingPowerup.append(power)
		var progressBar = load("res://scenes/objects/progressbarpowerup.tscn").instantiate()
		progressBar.sprite = load(pwrupController.spriteList[(power-1)])
		progressBar.power = power
		progressList.add_child(progressBar)
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$AnimationPlayer.play("out")
		pwrupController.action(power, self)
		await $AnimationPlayer.animation_finished
		queue_free()
