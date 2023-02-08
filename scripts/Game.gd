extends Node2D

var score = 0
var time = 120
var combo = 0

signal lost

func _ready():
	$LeftHUD/CreditsLabel2.text = str(Global.credits)

func _process(delta):
	if Input.is_action_just_pressed("coin") and Global.credits < 9:
		Global.credits += 1
		$Credit.play()
		_ready()
	
	if time < 0:
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
	
	time -= delta
	$RightHUD/TimeLabel2.text = "%0.1f" % time

func _on_FallZone_body_exited(body):
	emit_signal("lost")

func add_score(add):
	score += add
	$LeftHUD/ScoreLabel2.text = str(score)

func combo():
	$ComboTimer.start()
	combo += 1
	if combo == 2:
		$RightHUD/ComboLabel.show()
		$RightHUD/ComboLabel2.show()
	$RightHUD/ComboLabel2.text = "x" + str(combo)

func _on_ComboTimer_timeout():
	if combo > 1:
		time += combo
		add_score(100 * combo)
	combo = 0
	$RightHUD/ComboLabel.hide()
	$RightHUD/ComboLabel2.hide()
