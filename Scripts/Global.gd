extends Node

# Variáveis Fixas
var life = 100
var score = 0
var screen = false
var door = false

# Funções
func GameOver():
	await get_tree().create_timer(0.1).timeout
	life = 10
	score = 0
	get_tree().reload_current_scene()
	pass

func LoseLife(valor : int):
	life -= valor
	if life <= 0:
		GameOver()
	pass

func ScreenOnGlobal():
	screen = true
	door = true
	pass

func DoorOpenGlobal():
	await get_tree().create_timer(0.5).timeout
	door = false
	screen = false
	pass
