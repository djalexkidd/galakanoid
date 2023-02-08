extends Area2D

func _ready():
	if Global.fart_mode:
		$StaticBody2D/CollisionShape2D.queue_free()

func _on_Brick_body_entered(body):
	hide()
	$StaticBody2D.set_collision_layer_bit(0, false)
	$StaticBody2D.set_collision_mask_bit(0, false)
	$Timer.start()
	get_node("/root/Game").add_score(100)
	if Global.fart_mode:
		get_node("/root/Game/BrickBreakFart").play()
	else:
		get_node("/root/Game/BrickBreak").play()
	get_node("/root/Game").combo()
	get_node("/root/Game").check_victory()
	queue_free()
