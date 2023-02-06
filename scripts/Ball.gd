extends KinematicBody2D

var velocity = Vector2(0,0)
var SPEEDX = 360
var SPEEDY = 180

func _physics_process(delta):
	if is_on_floor():
		if position.y > 600:
			randomize()
			$AudioStreamPlayer.play()
			if SPEEDX > 0:
				SPEEDX = rand_range(0,600)
			else:
				SPEEDY = rand_range(180,400)
		SPEEDY = -SPEEDY
	elif is_on_ceiling():
		SPEEDY = -SPEEDY
	elif is_on_wall():
		SPEEDX = -SPEEDX
	
	velocity.x = SPEEDX
	velocity.y = SPEEDY
	
	velocity = move_and_slide(velocity,Vector2.UP)
