extends CanvasLayer

func _physics_process(delta):
	$Life/Life.text = str(Global.life) + "%"
	$Score/Score.text = str(Global.score)
	pass
