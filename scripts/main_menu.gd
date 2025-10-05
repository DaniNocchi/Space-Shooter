extends Node2D
func _ready():
	$stars/Stars2.emitting=true
	$UI/mainButtons/startButton.manageFocus(1)
	$UI/mainButtons/startButton.focus_mode = Control.FOCUS_ALL
	DiscordRPC.app_id = 1084242258229993533 # Application ID
	DiscordRPC.details = "On the Main Menu"
	DiscordRPC.large_image = "logo" 
	DiscordRPC.large_image_text = "Space Shooter"
	DiscordRPC.refresh()
	
	
	

func _process(delta: float) -> void:
	match controller.locale:
		1:
			$UI/creditsAnimation/CanvasLayer/Label.text = "Skipping..."
			$UI/mainButtons/startButton.text = "Start Game"
			$UI/mainButtons/optionsButton.text = "Settings"
			$UI/mainButtons/creditsButton.text = "Credits"
			$UI/mainButtons/quitButton.text = "Quit"
			$"UI/made by".text = "Made by DaniNocchi"
			$UI/version.text = "Version "+controller.version
		2:
			$UI/creditsAnimation/CanvasLayer/Label.text = "Pulando..."
			$UI/mainButtons/startButton.text = "Começar o Jogo"
			$UI/mainButtons/optionsButton.text = "Configurações"
			$UI/mainButtons/creditsButton.text = "Creditos"
			$UI/mainButtons/quitButton.text = "Sair"
			$"UI/made by".text = "Feito por DaniNocchi"
			$UI/version.text = "Versão "+controller.version
		3:
			$UI/creditsAnimation/CanvasLayer/Label.text = "Saltando..."
			$UI/mainButtons/startButton.text = "Comenzar Juego"
			$UI/mainButtons/optionsButton.text = "Ajustes"
			$UI/mainButtons/creditsButton.text = "Creditos"
			$UI/mainButtons/quitButton.text = "Salir"
			$"UI/made by".text = "Hecho por DaniNocchi"
			$UI/version.text = "Versión "+controller.version

	
