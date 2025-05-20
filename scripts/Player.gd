extends KinematicBody2D

var gravidade = 15
var posicao = Vector2.ZERO

func _physics_process(delta):
	posicao.y += gravidade
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			posicao.y -= 300
		
	posicao = move_and_slide(posicao, Vector2.UP)
	
