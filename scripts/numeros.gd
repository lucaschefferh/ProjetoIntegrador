extends Area2D

#Script do número para o player conseguir coletar e ter limite máximo de números
@export var value: int = 0
var player_in_area: CharacterBody2D = null

func _ready():
	$Label.text = str(value)
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = body

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = null

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interagir"):
	
		if player_in_area.numeros_coletados.size() < player_in_area.limite_mochila:
			player_in_area.adicionar_numero(value)
			queue_free()
		else:
			print("Você já atingiu o limite da mochila!")
