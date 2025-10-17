extends Resource
func action(owner):
	controller.newPersonalRecord()
	owner.get_tree().quit()
