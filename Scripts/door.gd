extends StaticBody2D


func _on_area_2d_area_entered(area):
	if area.collision_mask == 4 and Global.screen == true:
		Global.DoorOpenGlobal()
		$AnimatedSprite2D.play("open")
		await get_tree().create_timer(0.5).timeout
		queue_free()
		
	pass
