extends Resource
func action(owner):
	controller.save_game()
	Input.action_press("back")
	Input.action_release("back")
