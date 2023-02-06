extends KinematicBody2D

var velocity = Vector2(0,0)
var SPEEDX = 360
var SPEEDY = 180

func _physics_process(delta):
	if is_on_floor() or is_on_ceiling():
		SPEEDY = -SPEEDY
	elif is_on_wall():
		SPEEDX = -SPEEDX
	
	velocity.x = SPEEDX
	velocity.y = SPEEDY
	
	velocity = move_and_slide(velocity,Vector2.UP)
