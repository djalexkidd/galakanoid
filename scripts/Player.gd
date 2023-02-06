extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 360

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"): #Touche droite
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"): #Touche droite
		velocity.x = -SPEED
	
	velocity = move_and_slide(velocity)
	
	velocity.x = lerp(velocity.x,0,1)
