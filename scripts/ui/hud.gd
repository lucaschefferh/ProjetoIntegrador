extends CanvasLayer

# --- REFERÊNCIAS AOS NÓS ---

# Slot 1 e 2 (Sempre visíveis)
@onready var label_slot1 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Label
@onready var label_slot2 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/Label

# Slot 3 (Oculto na Fase 1) - Caminho específico da sua cena
@onready var container_slot3 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer4
@onready var label_slot3 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer4/Label

# Operadores
@onready var label_op1 = $MarginContainer/VBoxContainer/HBoxContainer/Label   # Primeiro sinal
@onready var label_op2 = $MarginContainer/VBoxContainer/HBoxContainer/Label2  # Segundo sinal (Label2)

# Resultado (Objetivo)
@onready var label_objetivo = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/Label

# Cronômetro
@onready var label_tempo = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer5/HBoxContainer/LabelTempo

func _ready():
	limpar_slots()

func configurar_fase(valor_alvo: int, qtd_numeros: int, sinais: Array = ["+"]):
	label_objetivo.text = str(valor_alvo)
	
	if sinais.size() > 0:
		label_op1.text = sinais[0]
	
	if qtd_numeros == 3:
		# Se tivermos um segundo sinal na lista, usamos ele (ex: "-")
		if sinais.size() > 1:
			label_op2.text = sinais[1]
		else:
			label_op2.text = "-" # Padrão de segurança
			
		label_op2.visible = true       # Mostra o segundo sinal
		container_slot3.visible = true # Mostra o terceiro quadrado
		
	else:
		# Modo Fase 1 (Apenas 2 números)
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
	if label_tempo:
		label_tempo.text = "%02d:%02d" % [minutos, segundos]
