extends Node
@onready var debugNode = $"../../DebugMode"
func _process(delta: float) -> void:
	if pwrupController.oldWave != controller.Wave:
		pwrupController.oldWave = controller.Wave
		if debugNode.spawnPowerup:spawn()
func spawn():
	var chosenPowerup = pwrupController.powerupList.pick_random()
	var powerupObject = load("res://scenes/objects/powerup.tscn").instantiate()
	powerupObject.power = chosenPowerup
	powerupObject.progressList = $"../powerupList"
	$"../powerups".add_child(powerupObject)
