extends Control
var canSkip = true
func _ready():
	$stars/Stars2.emitting = true
func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		if canSkip:
			canSkip = false
			if $RichTextLabel.typing:
				$RichTextLabel.typing = false
				$RichTextLabel.visible_characters = $RichTextLabel.clean_text.length()
			else:
				Transition.change_scene("res://scenes/rooms/mainMenu.tscn")
	else: 
		canSkip = true
			
