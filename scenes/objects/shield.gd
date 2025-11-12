extends Area2D
var state = false
@onready var animation = $animation
@onready var player := $"../Player"
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("meteors") and state:
		area.life = 0
		area.damage()

func _process(delta):
	transform = player.transform
	
	if state: #caso internamente ele esteja ligado
		if !pwrupController.shieldOn: #e caso deveria desligar
			animation.play("out") #toca animação de desligar
			state = false #diz internamente que está desligado
	
	else: #caso contrario (internamente acha que está desligado)
		if pwrupController.shieldOn: #e caso deveria ligar
			animation.play("in") #toca animação de ligar
			state = true #diz internamente que está ligado
			
	
	
	#a variavel state aqui é importante por isso:
	
	#pwrupController.shieldOn == false
	#ou seja, deveria estar desligado
	
	#if !pwrupController.shieldOn:
	#	tocar animação de desligado
	
	#toda hora que está desligado ele tocaria a animação, então
	#como isso seria problematico, o state serve como um bool
	#para fazer isso acontecer somente 1 vez.
