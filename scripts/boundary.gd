extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullets"):
		body.queue_free()
		
	if body.is_in_group("meteors"):
		body.queue_free()
		controller.meteorAlive-=1
