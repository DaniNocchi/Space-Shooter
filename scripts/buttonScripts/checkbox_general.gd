extends CheckBox

@export var mainButton : bool = false
@export var menu : int = 0
@export var canGrabFocus : bool = true
@export var optionsCanDisable : bool = false
@export var sizeSpeed = 0.1
@export var defaultSize = 1.0
@export var selectedSize = 1.2
@export var horizontalAlign = HORIZONTAL_ALIGNMENT_CENTER
@export var canDisable = true
@export var canEnable = true
@export var selectAudio : AudioStreamPlayer
@export var clickAudio : AudioStreamPlayer

#Current Existing Menus
# 0: None
# 1: Main Menu
# 2: Options
# 3: Scoreboard
# 4: Pause
var is_pressing := false
var hovered := false
var is_focused := false
@onready var tween := get_tree().create_tween()

func _ready():
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
	if is_pressing or disabled:
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
	if !disabled:
		selectAudio.play()
	hovered = true
	update_button_scale()
func _on_mouse_exited():
	hovered = false
	if is_pressing:
		is_pressing = false
	update_button_scale()
func _on_focus_entered():
	if !disabled:
		selectAudio.play()
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
	if !disabled:
		clickAudio.play()
	

func changeFocus():
	if controller.gamepad and !disabled:
		focus_mode = Control.FOCUS_ALL
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		if mainButton and canGrabFocus:
			grab_focus()
			canGrabFocus = false
	else:
		focus_mode = Control.FOCUS_NONE
		mouse_filter = Control.MOUSE_FILTER_PASS
		canGrabFocus = true

func _process(delta):
	if controller.currentMenu == menu:
		disabled = false
	else:
		disabled = true
	changeFocus()
	alignment = horizontalAlign
