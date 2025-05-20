extends Area2D

const POSICOES_Y = [175]

var velocidade = 4
var posicao_y = 175

func _ready():
	position.x = 380
	posicao_y = POSICOES_Y[0]

func _physics_process(delta):
	position.x -= velocidade
	
	if position.x < -32:
		queue_free()


func _on_Enemie_body_entered(body):
	if body.name == "Player":
		if Global.score > Global.record:
			Global.record = Global.score
		get_tree().change_scene("res://scenes/Level1.tscn")
