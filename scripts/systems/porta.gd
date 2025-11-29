extends Area2D

# --- VARIÁVEIS NOVAS ---
# Criamos um "Menu" para você escolher o tipo da fase no Inspetor
enum TipoFase { SOMA_SIMPLES, SOMA_SUBTRACAO }
@export var tipo_da_fase: TipoFase = TipoFase.SOMA_SIMPLES

@export var proxima_fase: String = "res://scenes/levels/fase1.tscn"
@export var resultado_necessario: int = 11

# Importante: Na fase 2, lembre de mudar isso para 3 no Inspetor!
@export var quantidade_numeros: int = 2 

func _ready():
	self.body_entered.connect(_on_body_entered)
	call_deferred("iniciar_hud")

func iniciar_hud():
	var hud = get_tree().get_first_node_in_group("HUD")
	
	if hud:
		# Envia o resultado. 
		# Futuramente, se o HUD mudar visualmente, podemos enviar o tipo_da_fase aqui.
		hud.configurar_fase(resultado_necessario, quantidade_numeros)
	else:
		print("ERRO: Nó do HUD não encontrado! Verifique se ele está no grupo 'HUD'.")

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	var numeros = body.numeros_coletados

	# Verifica se já tem a quantidade certa (definida no export)
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

# --- LÓGICA MATEMÁTICA ALTERADA ---
func _combinacao_correta(numeros: Array) -> bool:
	
	# CASO 1: Fase Normal (A + B)
	if tipo_da_fase == TipoFase.SOMA_SIMPLES:
		if numeros.size() < 2: return false
		# Soma os dois primeiros
		return numeros[0] + numeros[1] == resultado_necessario
	
	# CASO 2: Fase Nova (A + B - C)
	elif tipo_da_fase == TipoFase.SOMA_SUBTRACAO:
		if numeros.size() < 3: return false
		# Soma os dois primeiros e subtrai o terceiro
		return (numeros[0] + numeros[1]) - numeros[2] == resultado_necessario
		
	return false

func abrir_porta():
	print("PORTA ABERTA! Carregando próxima fase...")
	if proxima_fase != "":
		get_tree().change_scene_to_file(proxima_fase)
	else:
		print("Cena da próxima fase não definida!")
