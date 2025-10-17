extends Node
var powerupList = [1, 2, 2, 2]
#Powerup List:
#1- Double Points .
#2- Fast Shooting 
#3- Rotating Shield
#4- +150 Points
#5- Aimbot
#6- Freeze
#7- Player Invencibility
#8- +1 Life
#9- Triple Bullets
#10- Damage Pulse

var oldWave = controller.Wave
func _process(delta: float) -> void:
	if oldWave != controller.Wave:
		oldWave = controller.Wave
		spawn()
func spawn():
	var filteredList = powerupList.filter(func(p): return p not in controller.existingPowerup)
	if filteredList.size() != 0:
		var chosenPowerup = filteredList.pick_random()
		var powerupObject = load("res://scenes/objects/powerup.tscn").instantiate()
		powerupObject.power = chosenPowerup
		powerupObject.progressList = $"../powerupList"
		$"..".add_child(powerupObject)
		controller.existingPowerup.append(chosenPowerup)
