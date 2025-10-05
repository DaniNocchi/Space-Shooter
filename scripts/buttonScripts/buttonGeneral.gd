extends Button

@export var mainButton : bool = false
@export var canGrabFocus : bool = true
@export var optionsCanDisable : bool = false
var verySpecificVar = false
@export var sizeSpeed = 0.1
@export var defaultSize = 1.0
@export var selectedSize = 1.2
@export var horizontalAlign = HORIZONTAL_ALIGNMENT_CENTER
@export var actionScript : Script
@export var canDisable = true
@export var canEnable = true
var action_instance

var is_pressing := false
var hovered := false
var is_focused := false
@onready var tween := get_tree().create_tween()

func _ready():
	if actionScript:
		action_instance = actionScript.new()
	if horizontalAlign == HORIZONTAL_ALIGNMENT_CENTER:
		pivot_offset = size/2
	if !is_connected("mouse_entered", Callable(self, "_on_mouse_entered")):  connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	if !is_connected("mouse_exited",  Callable(self, "_on_mouse_exited")):	 connect("mouse_exited",  Callable(self, "_on_mouse_exited"))
	if !is_connected("focus_entered", Callable(self, "_on_focus_entered")):	 connect("focus_entered", Callable(self, "_on_focus_entered"))
	if !is_connected("focus_exited",  Callable(self, "_on_focus_exited")):	 connect("focus_exited",  Callable(self, "_on_focus_exited"))
	if !is_connected("button_down",   Callable(self, "_on_button_down")):	 connect("button_down",   Callable(self, "_on_button_down"))
	if !is_connected("button_up", 	  Callable(self, "_on_button_up")): 	 connect("button_up", 	  Callable(self, "_on_button_up"))
	scale = Vector2(defaultSize, defaultSize)

func _play_tween(target: Vector2, duration: float):
	if tween and tween.is_valid(): tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", target, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func update_button_scale():
	# PRIORIDADE MÁXIMA: Se está pressionando, sempre pequeno
	if is_pressing:
		_play_tween(Vector2(defaultSize, defaultSize), sizeSpeed)
		return  # Sai da função aqui, ignora o resto
	
	# Se não está pressionando, aí sim verifica hover/focus
	if controller.gamepad:
		if hovered or is_focused:
			_play_tween(Vector2(selectedSize, selectedSize), sizeSpeed)
		else:
			_play_tween(Vector2(defaultSize, defaultSize), sizeSpeed)
	else:
		if hovered:
			_play_tween(Vector2(selectedSize, selectedSize), sizeSpeed)
		else:
			_play_tween(Vector2(defaultSize, defaultSize), sizeSpeed)
func _on_mouse_entered():
	hovered = true
	update_button_scale()
func _on_mouse_exited():
	hovered = false
	if is_pressing:
		is_pressing = false
	update_button_scale()
func _on_focus_entered():
	is_focused = true
	update_button_scale()
func _on_focus_exited():
	is_focused = false
	if is_pressing:
		is_pressing = false
	update_button_scale()
func _on_button_down():
	is_pressing = true
	update_button_scale()
func _on_button_up():
	is_pressing = false
	update_button_scale()
	if action_instance and action_instance.has_method("action"):
		action_instance.action(self)

#region managing focus stuff
func removeFocusFromMouse():
	if controller.gamepad and !disabled:
		focus_mode = Control.FOCUS_ALL
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		manageFocus(1)
	else:
		focus_mode = Control.FOCUS_NONE
		mouse_filter = Control.MOUSE_FILTER_PASS
		manageFocus(2)
func manageFocus(action):
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
			if canDisable: disabled=true
			manageFocus(2)
		else:
			if canEnable: disabled=false
			if controller.gamepad: focus_mode = Control.FOCUS_ALL
			if controller.gamepad: manageFocus(1)
func _process(delta):
	removeFocusFromMouse()
	update_button_scale()
	disableOnOptionsOn()
	alignment = horizontalAlign
