extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("meteors"):
		body.damage()
		var explosion = preload("res://scenes/objects/damageMeteorParticle.tscn").instantiate()
		get_tree().current_scene.add_child(explosion)
		explosion.transform = transform
		explosion.emitting = true
		get_parent().queue_free() # apaga a bala
