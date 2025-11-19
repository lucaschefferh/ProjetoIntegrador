extends CanvasLayer

@onready var label_objetivo = $LabelObjetivo
@onready var label_coletados = $LabelColetados

func set_objetivo(r, q):
	label_objetivo.text = "Objetivo: %s usando %s números" % [r, q]

func set_coletados(lista):
	if lista.is_empty():
		label_coletados.text = "Coletados: ---"
	else:
		label_coletados.text = "Coletados: " + ", ".join(lista)
