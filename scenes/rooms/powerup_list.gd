extends VBoxContainer

@onready var player = $"../Player"
@onready var playerCol = $"../Player/Collision"

func _process(delta):
	var camera = get_viewport().get_camera_2d()
	if not camera:
		push_error("Nenhuma Camera2D encontrada!")
		return

	var player_screen_pos = player.global_position

	
	# 2. Retângulo global do VBoxContainer (em coordenadas da tela)
	var rect = get_global_rect()
	draw_rect(rect, Color(1,0,0,0.3), true)
	# 3. Calcula a distância entre o ponto do player e o retângulo (contando borda)
	var dx = max(rect.position.x - player_screen_pos.x, player_screen_pos.x - (rect.position.x + rect.size.x), 0)
	var dy = max(rect.position.y - player_screen_pos.y, player_screen_pos.y - (rect.position.y + rect.size.y), 0)
	var dist = sqrt(dx * dx + dy * dy)
	queue_redraw()
	print(dist)

func _draw() -> void:
	
	
