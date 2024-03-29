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
	if get_node_or_null("../Ball"):
		get_node("../Ball/RespawnTimer").start()
	else:
		get_node("../Player/Ball/RespawnTimer").start()
	if time_left == -1:
		$Timer.queue_free()
		get_node("../GameOverScreen").show()
		get_node("../GameOverScreen/AudioStreamPlayer").play()

func _on_AudioStreamPlayer_finished():
	if get_node("..").score > Global.highscore and !Global.fart_mode:
		save_highscore()
		Global.last_score = get_node("..").score
		Global.last_level = get_node("..").level + 1
		get_tree().change_scene("res://scenes/NewHighScore.tscn")
	else:
		get_tree().change_scene("res://scenes/TitleScreen.tscn")

# Sauvegarde le meilleur score
func save_highscore():
	var data = {
		"highscore" : get_node("..").score
	}
	
	var save_file = File.new()
	save_file.open("user://highscore.json", File.WRITE)
	save_file.store_line(to_json(data))
	save_file.close()
