extends Node
@export var normalPlayerMovement := false
@export var noPlayerDamage := false
@export var noPlayerKnockback := false
@export var canChangePlayerMaxSpeed := false
@export_range(0.0, 10.0) var playerMaxSpeed: float = 2.0
@export var spawnPowerup := false
@export var toggleMeteorSpawn := true
@export var killAllMeteors := false


func _process(delta: float) -> void:
	pass
