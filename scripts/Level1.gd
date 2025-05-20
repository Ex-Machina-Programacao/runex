extends Node2D

const INIMIGO = preload("res://scenes/Enemie.tscn")

func _ready():
	Global.score = 0

func _on_TimerEnemie_timeout():
	var inimigo = INIMIGO.instance()
	add_child(inimigo)
	
func _on_TimerScore_timeout():
	Global.score += 1
	print(String(Global.score) + " PONTOS")
	print("RECORD: " + String(Global.record))
