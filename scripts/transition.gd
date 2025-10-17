extends CanvasLayer

func change_scene(target, skipFadeIn := false):
	if !skipFadeIn: 
		$AnimationPlayer.play('transitionIn')
		await $AnimationPlayer.animation_finished
	$ColorRect.color = Color(0, 0, 0, 1)
	get_tree().change_scene_to_file(target)
	await get_tree().process_frame
	$AnimationPlayer.play('transitionOut')
	await $AnimationPlayer.animation_finished
