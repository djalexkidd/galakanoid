extends Node2D

var score = 0
var time = 120

func _ready():
	$LeftHUD/CreditsLabel2.text = str(Global.credits)

func _process(delta):
	if Input.is_action_just_pressed("coin") and Global.credits < 9:
		Global.credits += 1
		$Credit.play()
		_ready()
	
	time -= delta
	$RightHUD/TimeLabel2.text = "%0.1f" % time

func _on_FallZone_body_exited(body):
	get_tree().reload_current_scene()

func add_score(add):
	score += add
	$LeftHUD/ScoreLabel2.text = str(score)
