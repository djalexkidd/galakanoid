extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 360
var speed_multiplicator = 1

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"): #Touche droite
		velocity.x = SPEED * speed_multiplicator
	elif Input.is_action_pressed("ui_left"): #Touche droite
		velocity.x = -SPEED * speed_multiplicator
	
	if Input.is_action_just_pressed("ui_select"):
		speed_multiplicator = 2
	
	if Input.is_action_just_released("ui_select"):
		speed_multiplicator = 1
	
	velocity = move_and_slide(velocity)
	
	velocity.x = lerp(velocity.x,0,1)
