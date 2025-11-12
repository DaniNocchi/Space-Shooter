extends RichTextLabel

@export var base_speed := 0.03  # tempo entre letras
@export var delay_marker := "«"  # marcador de pausa
@export var end_marker := "»"  # marcador de fim de pausa (opcional)
var textGeneral = "[center]Game Over«0.5»[br][font size=8][br][color=BBBBBB]Lets see some stats from your gameplay«0.1».«0.1».«0.1».«0.5»[br]You got [wave amp=10 freq=10][rainbow freq=0.4]"+ str(controller.Points) + " points![/rainbow][/wave]«0.5»[br]You survived [wave amp=10 freq=10][rainbow freq=0.4]" + str(controller.Wave) + " waves![/rainbow][/wave]«0.5»[br][wave amp=10 freq=10][rainbow freq=0.4]" + str(controller.meteorKilled) + " Meteors[/rainbow][/wave] were destroyed!«0.5»[br]You shot [wave amp=10 freq=10][rainbow freq=0.4]" + str(controller.bulletsShot) + " bullets[/rainbow][/wave]«0.5» and [color=FFFFFF]missed " + str(controller.bulletsMissed) + " of them«0.1».«0.1».«0.1».«0.5»«0.5»[br][color=BBBBBB]You got [wave amp=10 freq=10][rainbow freq=0.4]" + str(controller.powerupsGotten) + " Powerups![/rainbow][/wave]«1.0»"
var textSuccess = "[br][br][color=BBBBBB]You got a [color=FFFFFF]NEW PERSONAL RECORD!«0.3»[br][shake rate=15.0 level=3][rainbow freq=0.4]" + str(controller.personalRecord) + " Points![/rainbow][/shake]«0.5»[br][font size=6][color=888888](Old Record: " + str(int(controller.oldPersonalRecord)) + " Points)"
var textFailed = "[br][br][color=BBBBBB]You did not pass your Personal Record«0.1».«0.1».«0.1».«0.5»[br][font size=6][color=888888](Personal Record: " + str(int(controller.oldPersonalRecord)) + " Points)"

var typing := true
var text_to_show: String
var clean_text := ""  # texto sem marcadores
var delay_positions := {}  # posição -> tempo de delay

func _ready():
	text_to_show = setText()
	_parse_text()
	text = clean_text
	visible_characters = 0
	await _type_text()
	typing = false

func _parse_text():
	var i := 0
	var clean_index := 0
	var inside_bbcode := false
	
	while i < text_to_show.length():
		var current_char := text_to_show[i]
		
		# Se encontrar um marcador de delay
		if current_char == delay_marker:
			var delay_time := base_speed * 5  # delay padrão
			var delay_str := ""
			i += 1
			
			# Ler o número do delay
			while i < text_to_show.length() and (text_to_show[i].is_valid_float() or text_to_show[i] == "."):
				delay_str += text_to_show[i]
				i += 1
			
			if delay_str != "":
				delay_time = float(delay_str)
			
			# Guardar o delay na posição atual do texto limpo (apenas caracteres visíveis)
			delay_positions[clean_index] = delay_time
			
			# Pular o marcador de fechamento se existir
			if i < text_to_show.length() and text_to_show[i] == end_marker:
				i += 1
			
			continue
		
		# Ignorar marcador de fechamento solto
		if current_char == end_marker:
			i += 1
			continue
		
		# Detectar início de tag BBCode
		if current_char == "[":
			inside_bbcode = true
		
		# Detectar fim de tag BBCode
		if current_char == "]":
			inside_bbcode = false
			clean_text += current_char
			i += 1
			continue
		
		# Adicionar caractere ao texto limpo
		clean_text += current_char
		
		# Só incrementar clean_index se não estiver dentro de uma tag BBCode
		if not inside_bbcode:
			clean_index += 1
		
		i += 1

func _type_text():
	for i in range(clean_text.length()):
		# Verificar se há delay nesta posição
		if delay_positions.has(i):
			await get_tree().create_timer(delay_positions[i]).timeout
		
		visible_characters += 1
		await get_tree().create_timer(base_speed).timeout

func setText():
	var _text = ""
	if controller.Points >= controller.oldPersonalRecord: _text = textGeneral + textSuccess
	else: _text = textGeneral + textFailed
	return _text
