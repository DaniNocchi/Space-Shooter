extends Node
var fix = false
func _process(delta):
	if controller.gamepad and !controller.optionsEnabled:
		if !fix:
			get_node("../startButton").focus_mode = Control.FOCUS_ALL
			get_node("../startButton").grab_focus()
			fix=true
	else:
		fix=false
		
# "why?" you ask.
# well... I couldnt find any better way of doing this
# and yes, thats a pretty big path, i know. Dont touch 
# if it works.
