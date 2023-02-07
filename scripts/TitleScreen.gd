extends Control

func _ready():
	$CreditsValue.text = str(Global.credits)
	if Global.credits > 0:
		$InsertCoinLabel.text = "PRESS START"
		$InsertCoinLabel2.text = "(PRESS 1)"
	
	if Global.mouse:
		$ControlButton.text = "MOUSE"
	else:
		$ControlButton.text = "KEYBOARD"

func _process(delta):
	if Input.is_action_just_pressed("coin") and Global.credits < 9:
		Global.credits += 1
		$Credit.play()
		_ready()
	
	if Input.is_action_just_pressed("start") and Global.credits > 0:
		Global.credits -= 1
		get_tree().change_scene("res://scenes/Game.tscn")

func _on_ControlButton_pressed():
	if Global.mouse:
		$ControlButton.text = "KEYBOARD"
		Global.mouse = false
	else:
		$ControlButton.text = "MOUSE"
		Global.mouse = true

func _on_FullScreenButton_pressed():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true
