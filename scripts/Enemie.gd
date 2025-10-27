extends Area2D

const POSICOES_Y = [130, 140]

var velocidade = 3

func _ready():
	position.x = 460 # fora da tela até para ultrawide
	position.y = POSICOES_Y[randi() % 2]

func _physics_process(delta):
	position.x -= velocidade
	
	if position.x < -32:
		queue_free()


func _on_Enemie_body_entered(body):
	if body.name == "Player":
		if Global.score > Global.record:
			Global.record = Global.score
		get_tree().change_scene("res://scenes/Level1.tscn")
