extends Area2D

@export var proxima_fase: String = "res://scenes/levels/fase2.tscn"
@export var resultado_necessario: int = 11
# A quantidade de números não precisa mais ser enviada pro HUD visualmente, 
# mas mantemos aqui para lógica do jogo se precisar no futuro.
@export var quantidade_numeros: int = 2 

func _ready():
	self.body_entered.connect(_on_body_entered)
	
	# IMPORTANTE: Espera 1 frame para garantir que o HUD carregou
	# antes de tentar mandar dados para ele.
	call_deferred("iniciar_hud")

func iniciar_hud():
	# Busca o HUD pelo GRUPO (muito mais seguro que get_node)
	var hud = get_tree().get_first_node_in_group("HUD")
	
	if hud:
		# Envia o resultado esperado e o operador (padrão "+")
		hud.set_objetivo(resultado_necessario, "+")
	else:
		print("ERRO: Nó do HUD não encontrado! Verifique se ele está no grupo 'HUD'.")

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	var numeros = body.numeros_coletados

	# Verifica se já tem a quantidade certa antes de checar a soma
	if numeros.size() < quantidade_numeros:
		print("Faltam números! Você tem: ", numeros.size())
		return

	if _combinacao_correta(numeros):
		abrir_porta()
	else:
		print("Soma incorreta! Tente outros números.")

func _combinacao_correta(numeros: Array) -> bool:
	# Soma simples dos dois primeiros números
	return numeros[0] + numeros[1] == resultado_necessario

func abrir_porta():
	print("PORTA ABERTA! Carregando próxima fase...")
	# Verifica se a cena existe antes de trocar para evitar crash
	if proxima_fase != "":
		get_tree().change_scene_to_file(proxima_fase)
	else:
		print("Cena da próxima fase não definida!")
