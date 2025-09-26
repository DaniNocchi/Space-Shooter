extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("meteors"):
		body.queue_free()
		controller.meteorAlive-=1


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		area.queue_free()
		
