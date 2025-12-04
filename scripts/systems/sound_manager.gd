extends Node

@onready var sfx_coleta = $SfxColeta
@onready var sfx_porta = $SfxPorta

# Funções que outros scripts vão chamar
func tocar_coleta():
	if sfx_coleta:
		sfx_coleta.play()

func tocar_porta():
	if sfx_porta:
		sfx_porta.play()
