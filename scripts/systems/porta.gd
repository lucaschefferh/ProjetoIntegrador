extends Area2D

# --- MENU DE TIPOS DE FASE ---
# Adicionamos Multiplicação e Divisão na lista
enum TipoFase { SOMA_SIMPLES, SOMA_SUBTRACAO, SOMA_MULTIPLICACAO, SOMA_DIVISAO }
@export var tipo_da_fase: TipoFase = TipoFase.SOMA_SIMPLES

@export var proxima_fase: String = "res://scenes/levels/fase1.tscn"
@export var resultado_necessario: int = 11

# Importante: Na fase 2, 3 e 4, lembre de mudar isso para 3 no Inspetor!
@export var quantidade_numeros: int = 2 

func _ready():
	self.body_entered.connect(_on_body_entered)
	call_deferred("iniciar_hud")

func iniciar_hud():
	var hud = get_tree().get_first_node_in_group("HUD")
	
	if hud:
		# Define quais sinais visuais aparecem na tela (Enviamos uma lista)
		var sinais_visuais = ["+"] # Padrão
		
		match tipo_da_fase:
			TipoFase.SOMA_SUBTRACAO:
				sinais_visuais = ["+", "-"]
			
			TipoFase.SOMA_MULTIPLICACAO:
				sinais_visuais = ["x", "-"] # Visual: (A x B) - C
			
			TipoFase.SOMA_DIVISAO:
				sinais_visuais = ["÷", "-"] # Visual: (A / B) - C
		
		# Chama a função atualizada do HUD passando os sinais
		hud.configurar_fase(resultado_necessario, quantidade_numeros, sinais_visuais)
	else:
		print("ERRO: Nó do HUD não encontrado! Verifique se ele está no grupo 'HUD'.")

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	var numeros = body.numeros_coletados

	# Verifica se já tem a quantidade certa
	if numeros.size() < quantidade_numeros:
		print("Faltam números! Você tem: ", numeros.size(), " Precisa de: ", quantidade_numeros)
		return

	if _combinacao_correta(numeros):
		abrir_porta()
	else:
		print("Conta incorreta! A fase será reiniciada.")
		call_deferred("reiniciar_fase")

# Função auxiliar para evitar erros de física ao reiniciar
func reiniciar_fase():
	# Soma +1 no contador de erros global
	GameData.adicionar_tentativa() 
	print("Tentativas totais: ", GameData.tentativas)
	get_tree().reload_current_scene()

# --- LÓGICA MATEMÁTICA COMPLETA ---
func _combinacao_correta(numeros: Array) -> bool:
	
	match tipo_da_fase:
		# CASO 1: Soma Simples (A + B)
		TipoFase.SOMA_SIMPLES:
			if numeros.size() < 2: return false
			return numeros[0] + numeros[1] == resultado_necessario
		
		# CASO 2: Soma e Subtração (A + B - C)
		TipoFase.SOMA_SUBTRACAO:
			if numeros.size() < 3: return false
			return (numeros[0] + numeros[1]) - numeros[2] == resultado_necessario
			
		# CASO 3: Multiplicação (A * B - C)
		TipoFase.SOMA_MULTIPLICACAO:
			if numeros.size() < 3: return false
			# Primeiro multiplica os dois primeiros, depois subtrai o terceiro
			return (numeros[0] * numeros[1]) - numeros[2] == resultado_necessario
			
		# CASO 4: Divisão (A / B - C)
		TipoFase.SOMA_DIVISAO:
			if numeros.size() < 3: return false
			
			# Segurança: Não dividir por zero!
			if numeros[1] == 0:
				print("Erro: O divisor não pode ser zero!")
				return false
				
			# Primeiro divide os dois primeiros, depois subtrai o terceiro
			return (numeros[0] / numeros[1]) - numeros[2] == resultado_necessario
		
	return false

func abrir_porta():
	SoundManager.tocar_porta()
	print("PORTA ABERTA! Carregando próxima fase...")
	if proxima_fase != "":
		get_tree().change_scene_to_file(proxima_fase)
	else:
		print("Cena da próxima fase não definida!")
