extends Resource
func action(owner):
	var optionsMenu = load("res://scenes/objects/options.tscn").instantiate()
	optionsMenu.position = owner.global_position
	owner.get_node("..").add_child(optionsMenu)
	controller.optionsEnabled = true
	
