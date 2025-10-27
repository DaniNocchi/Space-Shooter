extends "res://scripts/buttonScripts/button_general.gd"
func action():
	get_node("../../creditsAnimation/AnimationPlayer").play("credits")
