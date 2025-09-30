extends Node
func _process(delta):
	if controller.gamepad and !controller.optionsEnabled:
		$"../startButton".manageFocus(1)
	else:
		$"../startButton".manageFocus(2)
	
	if get_node_or_null("../Options") != null:
		if controller.gamepad:
			get_node_or_null("../Options/options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/back").manageFocus(1)
		else:
			get_node_or_null("../Options/options/CanvasLayer/SettingsContainer/VBoxContainer/HBoxContainer/back").manageFocus(2)
			
		
# "why?" you ask.
# well... I couldnt find any better way of doing this
# and yes, thats a pretty big path, i know. Dont touch 
# if it works.
