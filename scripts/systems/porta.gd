extends Area2D

#Script para definir o tipo de fase e fazer a verificação de acordo com a fase
enum TipoFase { SOMA_SIMPLES, SOMA_SUBTRACAO, SOMA_MULTIPLICACAO, SOMA_DIVISAO }
@export var tipo_da_fase: TipoFase = TipoFase.SOMA_SIMPLES

@export var proxima_fase: String = "res://scenes/levels/fase1.tscn"
@export var resultado_necessario: int = 11


@export var quantidade_numeros: int = 2 

func _ready():
	self.body_entered.connect(_on_body_entered)
	call_deferred("iniciar_hud")

func iniciar_hud():
	var hud = get_tree().get_first_node_in_group("HUD")
	
	if hud:
		var sinais_visuais = ["+"] 
		match tipo_da_fase:
			TipoFase.SOMA_SUBTRACAO:
				sinais_visuais = ["+", "-"]
			
			TipoFase.SOMA_MULTIPLICACAO:
				sinais_visuais = ["x", "-"] 
			
			TipoFase.SOMA_DIVISAO:
				sinais_visuais = ["÷", "-"] 
		
		
		hud.configurar_fase(resultado_necessario, quantidade_numeros, sinais_visuais)
	else:
		print("ERRO: Nó do HUD não encontrado! Verifique se ele está no grupo 'HUD'.")

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	var numeros = body.numeros_coletados

	
	if numeros.size() < quantidade_numeros:
		print("Faltam números! Você tem: ", numeros.size(), " Precisa de: ", quantidade_numeros)
		return

	if _combinacao_correta(numeros):
		abrir_porta()
	else:
		print("Conta incorreta! A fase será reiniciada.")
		call_deferred("reiniciar_fase")


func reiniciar_fase():
	
	GameData.adicionar_tentativa() 
	print("Tentativas totais: ", GameData.tentativas)
	get_tree().reload_current_scene()

func _combinacao_correta(numeros: Array) -> bool:
	
	match tipo_da_fase:
	
		TipoFase.SOMA_SIMPLES:
			if numeros.size() < 2: return false
			return numeros[0] + numeros[1] == resultado_necessario
		
		
		TipoFase.SOMA_SUBTRACAO:
			if numeros.size() < 3: return false
			return (numeros[0] + numeros[1]) - numeros[2] == resultado_necessario
			
		
		TipoFase.SOMA_MULTIPLICACAO:
			if numeros.size() < 3: return false
			
			return (numeros[0] * numeros[1]) - numeros[2] == resultado_necessario
			
	
		TipoFase.SOMA_DIVISAO:
			if numeros.size() < 3: return false
			
			
			if numeros[1] == 0:
				print("Erro: O divisor não pode ser zero!")
				return false
				
			return (numeros[0] / numeros[1]) - numeros[2] == resultado_necessario
		
	return false

func abrir_porta():
	SoundManager.tocar_porta()
	print("PORTA ABERTA! Carregando próxima fase...")
	if proxima_fase != "":
		get_tree().change_scene_to_file(proxima_fase)
	else:
		print("Cena da próxima fase não definida!")
