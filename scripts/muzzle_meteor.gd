extends Marker2D
var rotationSpeed = 2.34
func _process(delta):
	rotation += rotationSpeed*delta
