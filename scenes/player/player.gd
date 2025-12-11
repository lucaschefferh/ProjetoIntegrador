extends CharacterBody2D

#Script do player, da a velocidade e gravidade para ele, os movimentos dele, e também a coleta de números
@export var speed := 200.0
@export var jump_force := -400.0
@export var gravity := 900.0

@export var limite_mochila: int = 2 


@onready var anim = $AnimatedSprite2D

var numeros_coletados: Array = []

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	var input_dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_dir * speed

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	_update_animation(input_dir)

	move_and_slide()


func _update_animation(input_dir: float) -> void:
	if input_dir != 0:
		anim.flip_h = input_dir < 0
		anim.play("walk")
	else:
		anim.play("idle")
		

func adicionar_numero(valor: int):
	if numeros_coletados.size() >= limite_mochila:
		print("Inventário cheio! Não cabe mais nada.")
		return
	# -----------------------------------
	SoundManager.tocar_coleta()
	
	numeros_coletados.append(valor)
	print("Sucesso! Coletados agora:", numeros_coletados)

	var hud = get_tree().get_first_node_in_group("HUD")
	if hud:
		hud.set_coletados(numeros_coletados)
