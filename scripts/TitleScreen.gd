extends Control

func _ready():
	$CreditsValue.text = str(Global.credits)

func _process(delta):
	if Input.is_action_just_pressed("coin") and Global.credits < 9:
		Global.credits += 1
		$Credit.play()
		_ready()
	
	if Input.is_action_just_pressed("start") and Global.credits > 0:
		Global.credits -= 1
		get_tree().change_scene("res://scenes/Game.tscn")
