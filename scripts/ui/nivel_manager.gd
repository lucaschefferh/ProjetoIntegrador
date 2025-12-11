extends Node2D

#Serve para só iniciar o cronometro quando sair do tutorial
func _ready() -> void:
	pass 
	GameData.iniciar_cronometro()

func _process(delta: float) -> void:
	pass
