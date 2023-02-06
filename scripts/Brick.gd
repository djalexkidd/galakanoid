extends Area2D

func _on_Brick_body_entered(body):
	hide()
	$StaticBody2D.set_collision_layer_bit(0, false)
	$StaticBody2D.set_collision_mask_bit(0, false)
	$Timer.start()

func _on_Timer_timeout():
	queue_free()
