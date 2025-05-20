extends Node

func _process(delta):
	$Control/LabelScore.text = String(Global.score) + " PONTOS"
