extends ScrollContainer
func _process(delta):
	if $VBoxContainer/soundSlider.editable:
		if Input.is_action_just_released("back"):
			$"../AnimationPlayer".play("out")
	if scroll_vertical == 12:
		scroll_vertical = 0
