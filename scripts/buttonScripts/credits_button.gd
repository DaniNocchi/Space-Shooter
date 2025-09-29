extends Resource
func action(owner):
	owner.get_node("../../creditsAnimation/AnimationPlayer").play("credits")
