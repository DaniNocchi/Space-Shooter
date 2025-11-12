extends ScrollContainer
func _process(delta):
	if Input.is_action_just_released("back"):
		$"../../..".playAnimation(false)
	if scroll_vertical == 12:
		scroll_vertical = 0
