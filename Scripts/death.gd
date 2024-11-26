extends Area2D

# Funções

func _on_area_entered(area):
	if Global.life > 1:
		Global.life -= 1
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
		Global.GameOver()
	pass
