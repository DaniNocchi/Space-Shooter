extends Area2D
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		area.queue_free()
		controller.bulletsMissed +=1
	if area.is_in_group("meteors"):
		area.queue_free()
		controller.meteorAlive -=1
