extends Area2D

@export var level = ""

func NextLevel(level):
	get_tree().change_scene_to_file(level)
	pass


func _on_area_entered(area):
	if area.collision_layer == 2:
		NextLevel(level)
	pass
