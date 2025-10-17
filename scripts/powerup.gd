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

	
