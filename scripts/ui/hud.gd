"""
Ele é responsável por atualizar visualmente os slots de números coletados,
exibir os operadores matemáticos (+, -), mostrar o valor alvo (objetivo)
e atualizar o cronômetro da fase em tempo real. A função configurar_fase
adapta a interface dinamicamente para suportar modos de jogo com 2 ou 3
números, ocultando ou exibindo os painéis e operadores extras conforme necessário.
"""

extends CanvasLayer

@onready var label_slot1 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Label
@onready var label_slot2 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/Label

@onready var container_slot3 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer4
@onready var label_slot3 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer4/Label

@onready var label_op1 = $MarginContainer/VBoxContainer/HBoxContainer/Label   
@onready var label_op2 = $MarginContainer/VBoxContainer/HBoxContainer/Label2  

@onready var label_objetivo = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/Label

@onready var label_tempo = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer5/HBoxContainer/LabelTempo

func _ready():
	limpar_slots()

func configurar_fase(valor_alvo: int, qtd_numeros: int, sinais: Array = ["+"]):
	label_objetivo.text = str(valor_alvo)
	
	if sinais.size() > 0:
		label_op1.text = sinais[0]
	
	if qtd_numeros == 3:
		if sinais.size() > 1:
			label_op2.text = sinais[1]
		else:
			label_op2.text = "-"
			
		label_op2.visible = true       
		container_slot3.visible = true 
		
	else:
		label_op2.visible = false       
		container_slot3.visible = false 

func set_coletados(lista_numeros: Array):
	if lista_numeros.size() >= 1:
		label_slot1.text = str(lista_numeros[0])
	else:
		label_slot1.text = "?"
	
	if lista_numeros.size() >= 2:
		label_slot2.text = str(lista_numeros[1])
	else:
		label_slot2.text = "?"
		
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
	var tempo = GameData.tempo_fase
	
	var minutos = int(tempo / 60)
	var segundos = int(tempo) % 60
	
	if label_tempo:
		label_tempo.text = "%02d:%02d" % [minutos, segundos]
