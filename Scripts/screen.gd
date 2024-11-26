extends StaticBody2D


func _on_screen_area_area_entered(area):
	if area.collision_mask == 4:
		$AnimatedSprite2D.play("on")
		Global.ScreenOnGlobal()
		pass
	pass # Replace with function body.
