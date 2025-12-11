extends Node

#Funções para os efeitos especiais 
@onready var sfx_coleta = $SfxColeta
@onready var sfx_porta = $SfxPorta

func tocar_coleta():
	if sfx_coleta:
		sfx_coleta.play()

func tocar_porta():
	if sfx_porta:
		sfx_porta.play()
