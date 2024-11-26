extends Node2D


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pass
