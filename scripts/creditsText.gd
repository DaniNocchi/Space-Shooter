extends RichTextLabel
func _process(delta: float) -> void:
	match controller.locale:
		1:
			text = "SPACE SHOOTER\n[font_size=8]\n\n\n\nDeveloper - DaniNocchi\nAudio - DaniNocchi, Vicent\nMusic - TalonTrueBlood\n\nfont_size=10]\nSpecial Thanks[font_size=8]\nAll my friends that tested the game\n\n\nYes, DaniNocchi (Me) did basically everything.\n\nActually, I did the game all by myself\nsince the first version of it."
		2:
			text = "SPACE SHOOTER
[font_size=8]



Desenvolvedor - DaniNocchi
Áudio - DaniNocchi, Vincent
Música - TalonTrueBlood

[font_size=10]
Agradecimentos Especiais[font_size=8]
Todos meus amigos que testaram o jogo.


Sim, DaniNocchi (Eu) fez basicamente tudo.

Na verdade, eu fiz o jogo todo sozinho
desde a primeira versão.
"
		3:
			text = "SPACE SHOOTER
[font_size=8]



Desarrollador - DaniNocchi
Audio - DaniNocchi, Vincent
Música - TalonTrueBlood

[font_size=10]
Agradecimiento Especial[font_size=8]
Todos mis amigos que probaram el juego.


Si, DaniNocchi (Yo) hice basicamente todo.

En realidad, hice el juego yo solo
desde la primera versión.
"
