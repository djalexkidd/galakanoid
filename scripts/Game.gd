extends Node2D

var score = 0
var time = 123
var combo = 0
var level = 0
var next_level = 0
var score_objective = [2900,5900,8900,11900,15900]

var current_bg = 1

var gameover

signal lost

func _ready():
	$LeftHUD/CreditsLabel2.text = str(Global.credits)
	emit_signal("lost")

func _process(delta):
	if Input.is_action_just_pressed("coin") and Global.credits < 9:
		Global.credits += 1
		$Credit.play()
		$LeftHUD/CreditsLabel2.text = str(Global.credits)
	
	if "%0.1f" % time == "0.0":
		$GameOver.start()
		gameover_hide()
		set_process(false)
	
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
	check_victory()

func check_victory():
	if score > score_objective[next_level] and level == next_level:
		$Exit/MeshInstance2D.show()
		$Walls/Exit.set_deferred("disabled", true)
		$Exit2/MeshInstance2D.show()
		$Walls/Exit2.set_deferred("disabled", true)
		$ExitOpened.play()
		next_level += 1

func _on_Exit_body_exited(body):
	get_node("Bricks" + str(level+1)).queue_free()
	level += 1
	$Exit/MeshInstance2D.hide()
	$Walls/Exit.set_deferred("disabled", false)
	$Exit2/MeshInstance2D.hide()
	$Walls/Exit2.set_deferred("disabled", false)
	
	var level_data_path = "res://scenes/levels/Level" + str(level+1) + ".tscn"
	var level_data = load(level_data_path).instance()
	level_data.set_name("Bricks" + str(level+1))
	add_child(level_data)
	
	$Ball.position = Vector2(824, 700)
	
	change_field()
	time += 20

func change_field():
	current_bg += 1
	if current_bg == 5:
		get_node("Field" + str(current_bg-1)).hide()
		$Field1.show()
	else:
		get_node("Field" + str(current_bg-1)).hide()
		get_node("Field" + str(current_bg)).show()
	if current_bg == 5:
		current_bg = 1

func gameover_hide():
	get_node("Field" + str(current_bg)).hide()
	$Player.hide()
	if get_node_or_null("Ball"):
		$Ball._on_Game_lost()
	get_node("Bricks" + str(level+1)).hide()

func _on_GameOver_okay():
	time = 120
	get_node("Field" + str(current_bg)).show()
	$Player.show()
	get_node("Bricks" + str(level+1)).show()
	set_process(true)
