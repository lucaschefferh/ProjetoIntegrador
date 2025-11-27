extends CanvasLayer

# --- Referências aos Nós (Baseado na sua última árvore) ---
@onready var label_slot1 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Label
@onready var label_slot2 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/Label
@onready var label_objetivo = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/Label
@onready var label_operador = $MarginContainer/VBoxContainer/HBoxContainer/Label

func _ready():
	# Inicializa o HUD limpo
	limpar_slots()

# Chamado pela Porta/LevelManager no início da fase
func set_objetivo(valor_alvo: int, operador: String = "+"):
	label_objetivo.text = str(valor_alvo)
	label_operador.text = operador

# Chamado pelo Player toda vez que pega um número
func set_coletados(lista_numeros: Array):
	# 1. Slot 1
	if lista_numeros.size() >= 1:
		label_slot1.text = str(lista_numeros[0])
	else:
		label_slot1.text = "?" # Se não tem, mostra ?
	
	# 2. Slot 2
	if lista_numeros.size() >= 2:
		label_slot2.text = str(lista_numeros[1])
	else:
		label_slot2.text = "?"

func limpar_slots():
	label_slot1.text = "?"
	label_slot2.text = "?"
