extends Control

var time_left = 9

signal okay

func _ready():
	set_process(false)

func start():
	$Timer.start()
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("coin") and Global.credits < 9:
		Global.credits += 1
		get_node("../Credit").play()
		get_node("../LeftHUD/CreditsLabel2").text = str(Global.credits)
	if Input.is_action_just_pressed("start") and Global.credits > 0:
		Global.credits -= 1
		get_node("../LeftHUD/CreditsLabel2").text = str(Global.credits)
		emit_signal("okay")
		time_left = 9
		$Timer.stop()
		set_process(false)

func _on_Timer_timeout():
	time_left -= 1
	$TimeLeftLabel.text = str(time_left)
	if time_left == -1:
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
