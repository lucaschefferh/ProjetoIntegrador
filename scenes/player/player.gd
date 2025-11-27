extends CharacterBody2D

@export var speed := 200.0
@export var jump_force := -400.0
@export var gravity := 900.0

@onready var anim = $AnimatedSprite2D

var numeros_coletados: Array = []

func _physics_process(delta):
	# gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# movimento horizontal
	var input_dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_dir * speed

	# pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	# animação
	_update_animation(input_dir)

	move_and_slide()

func _update_animation(input_dir: float) -> void:
	if input_dir != 0:
		anim.flip_h = input_dir < 0
		anim.play("walk")
	else:
		anim.play("idle")
		
func adicionar_numero(valor: int):
	# Limite de 2 números (slots do HUD)
	if numeros_coletados.size() >= 2:
		print("Inventário cheio! Você já tem 2 números.")
		return
		
	numeros_coletados.append(valor)
	print("Coletados agora:", numeros_coletados)
	
	# Atualiza o HUD usando Grupo
	var hud = get_tree().get_first_node_in_group("HUD")
	if hud:
		hud.set_coletados(numeros_coletados)
