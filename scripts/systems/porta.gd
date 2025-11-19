extends Area2D

@export var proxima_fase: String = "res://scenes/levels/fase2.tscn"
@export var resultado_necessario: int = 10
@export var quantidade_numeros: int = 2

func _ready():
	self.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	var numeros = body.numeros_coletados

	if _combinacao_correta(numeros):
		abrir_porta()
	else:
		print("O jogador não tem os números necessários!")


func _combinacao_correta(numeros:Array) -> bool:
	for i in numeros:
		for j in numeros:
			if i != j and (i + j) == resultado_necessario:
				return true
	return false


func abrir_porta():
	print("PORTA ABERTA! Carregando próxima fase...")
	get_tree().change_scene_to_file(proxima_fase)
