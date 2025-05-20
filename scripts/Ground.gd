extends Node2D

export var velocidade = 100.0  # Velocidade em pixels por segundo
onready var ground1 = $TileMap1
onready var ground2 = $TileMap2

var largura_tilemap = 0.0

func _ready():
	# Calcula a largura do TileMap com base no tamanho da grade usada
	var rect = ground1.get_used_rect()
	largura_tilemap = rect.size.x * ground1.cell_size.x
	
	# Posiciona o segundo TileMap ao lado do primeiro
	ground2.position.x = ground1.position.x + largura_tilemap

func _physics_process(delta):
	# Move os TileMaps
	ground1.position.x -= velocidade * delta
	ground2.position.x -= velocidade * delta

	# Se o TileMap sair totalmente da tela, reposiciona ele para o final do outro
	if ground1.position.x <= -largura_tilemap:
		ground1.position.x = ground2.position.x + largura_tilemap

	if ground2.position.x <= -largura_tilemap:
		ground2.position.x = ground1.position.x + largura_tilemap
