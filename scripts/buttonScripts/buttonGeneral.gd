extends Button
@export var mainButton : bool = false
@export var canGrabFocus : bool = true
@export var optionsCanDisable : bool = false
var verySpecificVar = false
@onready var tween = get_tree().create_tween()
@export var sizeSpeed = 0.1
@export var defaultSize = 1.0
@export var selectedSize = 1.2
@export var disabledAlpha = 1.0
@export var horizontalAlign = HORIZONTAL_ALIGNMENT_CENTER
@export var actionScript : Script
var action_instance

func _ready():
	if actionScript:
		action_instance = actionScript.new()
		
	if horizontalAlign == HORIZONTAL_ALIGNMENT_CENTER:
		pivot_offset = size/2
	if !is_connected("mouse_entered", Callable(self, "_on_mouse_entered")):  connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	if !is_connected("mouse_exited",  Callable(self, "_on_mouse_exited")):	 connect("mouse_exited",  Callable(self, "_on_mouse_exited"))
	if !is_connected("focus_entered", Callable(self, "_on_focus_entered")):	 connect("focus_entered", Callable(self, "_on_focus_entered"))
	if !is_connected("focus_exited",  Callable(self, "_on_focus_exited")):	 connect("focus_exited",  Callable(self, "_on_focus_exited"))
	if !is_connected("pressed", 	  Callable(self, "_on_pressed")):		 connect("pressed", 	  Callable(self, "_on_pressed"))
	if !is_connected("button_up", 	  Callable(self, "_on_button_up")): 	 connect("button_up", 	  Callable(self, "_on_button_up"))
func _play_tween(target: Vector2, duration: float):
	if tween and tween.is_valid():
		tween.kill() 
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", target, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
func _on_mouse_entered():
	if not button_pressed and not disabled:
		_play_tween(Vector2(selectedSize, selectedSize), sizeSpeed)
func _on_mouse_exited():
	if not button_pressed:
		_play_tween(Vector2(defaultSize, defaultSize), sizeSpeed)
func _on_focus_entered():
	if not button_pressed and not disabled:
		_play_tween(Vector2(selectedSize, selectedSize), sizeSpeed)
func _on_focus_exited():
	if not button_pressed:
		_play_tween(Vector2(defaultSize, defaultSize), sizeSpeed)
func _on_pressed():
	_play_tween(Vector2(defaultSize, defaultSize), sizeSpeed)

#region managing focus stuff
func removeFocusFromMouse():
	if controller.gamepad:
		focus_mode = Control.FOCUS_ALL
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		if !disabled: manageFocus(1)
	else:
		manageFocus(2)
		focus_mode = Control.FOCUS_NONE
		mouse_filter = Control.MOUSE_FILTER_PASS
func manageFocus(action):
	if !disabled:
		match action:
			1:
				if mainButton:
					if canGrabFocus:
						grab_focus()
						canGrabFocus = false
			2:
				canGrabFocus = true
#endregion
func disableOnOptionsOn():
	if optionsCanDisable:
		if controller.optionsEnabled:
			disabled=true
			
		else:
			disabled=false
func _process(delta):
	removeFocusFromMouse()
	disableOnOptionsOn()
	if disabled:
		manageFocus(2)
		verySpecificVar = false
	else:
		if !verySpecificVar:
			manageFocus(1)
			verySpecificVar = true
	add_theme_color_override("font_disabled_color", Color(0.5, 0.5, 0.5, disabledAlpha))
	alignment = horizontalAlign

# BUTTON ACTION
func _on_button_up():
	if action_instance and action_instance.has_method("action"):
		action_instance.action(self)
