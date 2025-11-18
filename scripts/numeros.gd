extends Area2D

@export var value: int = 0

signal collected(value)

func _ready():
	$Label.text = str(value)
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Entrou na área:", body)
	if body.is_in_group("player"):
		print("É o player! Vou sumir...")
		emit_signal("collected", value)
		queue_free()
