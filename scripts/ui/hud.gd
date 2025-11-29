extends CanvasLayer

# --- REFERÊNCIAS AOS NÓS (Baseado na sua imagem) ---

# Slot 1 e 2 (Sempre visíveis)
@onready var label_slot1 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Label
@onready var label_slot2 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/Label

# Slot 3 (Oculto na Fase 1) - Na sua imagem é o PanelContainer4
@onready var container_slot3 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer4
@onready var label_slot3 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer4/Label

# Operadores
@onready var label_op1 = $MarginContainer/VBoxContainer/HBoxContainer/Label   # O sinal de +
@onready var label_op2 = $MarginContainer/VBoxContainer/HBoxContainer/Label2  # O sinal de - (Oculto na Fase 1)

# Resultado (Objetivo)
@onready var label_objetivo = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/Label

@onready var label_tempo = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer5/HBoxContainer/LabelTempo

func _ready():
	# Garante que o HUD comece limpo e no estado correto
	limpar_slots()

# --- CONFIGURAÇÃO DA FASE ---
# Essa função é chamada pela Porta para dizer se precisa de 2 ou 3 números
func configurar_fase(valor_alvo: int, qtd_numeros: int):
	label_objetivo.text = str(valor_alvo)
	
	# Se a fase exige 3 números (Fase 2: A + B - C)
	if qtd_numeros == 3:
		label_op1.text = "+"
		label_op2.text = "-"      # Define o segundo sinal como menos
		
		label_op2.visible = true       # Mostra o sinal de menos
		container_slot3.visible = true # Mostra o terceiro quadrado
		
	# Se a fase é normal (Fase 1: A + B)
	else:
		label_op1.text = "+"
		
		label_op2.visible = false       # Esconde o sinal extra
		container_slot3.visible = false # Esconde o terceiro quadrado

# --- ATUALIZAÇÃO DOS NÚMEROS ---
func set_coletados(lista_numeros: Array):
	# Slot 1
	if lista_numeros.size() >= 1:
		label_slot1.text = str(lista_numeros[0])
	else:
		label_slot1.text = "?"
	
	# Slot 2
	if lista_numeros.size() >= 2:
		label_slot2.text = str(lista_numeros[1])
	else:
		label_slot2.text = "?"
		
	# Slot 3 (Só preenche se ele estiver visível)
	if container_slot3.visible:
		if lista_numeros.size() >= 3:
			label_slot3.text = str(lista_numeros[2])
		else:
			label_slot3.text = "?"

func limpar_slots():
	label_slot1.text = "?"
	label_slot2.text = "?"
	if label_slot3:
		label_slot3.text = "?"

func _process(delta):
	# Pega o tempo acumulado no GameData
	var tempo = GameData.tempo_fase
	
	# Matemática para separar minutos e segundos
	var minutos = int(tempo / 60)
	var segundos = int(tempo) % 60
	
	# Atualiza o texto. "%02d" garante que fique "05" e não "5"
	# IMPORTANTE: Garanta que 'label_tempo' está conectado corretamente lá no @onready!
	if label_tempo:
		label_tempo.text = "%02d:%02d" % [minutos, segundos]
