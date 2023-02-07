extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 360
var speed_multiplicator = 1

func _ready():
	if Global.mouse:
		$Move.start()

#Suit le mouvement de la souris sur l'axe X
func _on_Move_timeout():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position",Vector2(position.x,position.y), Vector2(get_viewport().get_mouse_position().x,position.y),0.05 ,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

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
