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
				SPEEDY = rand_range(360,500)
		SPEEDY = -SPEEDY
	elif is_on_ceiling():
		SPEEDY = -SPEEDY
	elif is_on_wall():
		SPEEDX = -SPEEDX
	
	velocity.x = SPEEDX
	velocity.y = SPEEDY
	
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_Game_lost():
	position = Vector2(get_parent().position.x, get_parent().position.y)
	var new_parent = get_parent().get_node("Player")
	get_parent().remove_child(self)
	new_parent.add_child(self)
	
	SPEEDX = 0
	SPEEDY = 0
	
	$RespawnTimer.start()

func _on_RespawnTimer_timeout():
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)
	
	SPEEDX = 360
	SPEEDY = 180
	
	position = Vector2(get_node("../Player").position.x, get_node("../Player").position.y-25)
