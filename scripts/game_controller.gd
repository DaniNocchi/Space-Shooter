extends Node2D
var Wave = 1
var Points = 0
var MaxMeteor = 10
var meteorAlive = 0

func _process(_delta):
	Wave = (Points%25)+1
	MaxMeteor = 10*Wave
	
