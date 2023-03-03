extends Control

func _ready():
	$HTTPRequest.request("https://2022.alexandre.backhub.fr/api/galakanoid")

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	
	var rank = 1
	
	for i in json.result:
		var dataRank = Label.new()
		dataRank.text = str(rank)
		dataRank.add_font_override("font",load("res://assets/fonts/Retro_Leaderboard.tres"))
		dataRank.align = 2
		$GridContainer.add_child(dataRank)
		rank += 1
		var dataScore = Label.new()
		dataScore.text = str(i.score)
		dataScore.add_font_override("font",load("res://assets/fonts/Retro_Leaderboard.tres"))
		dataScore.align = 2
		$GridContainer.add_child(dataScore)
		var dataName = Label.new()
		dataName.text = i.name
		dataName.add_font_override("font",load("res://assets/fonts/Retro_Leaderboard.tres"))
		dataName.align = 2
		$GridContainer.add_child(dataName)
		if rank == 9:
			break
	
	$LoadingLabel.hide()
	$WebButton.show()

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_WebButton_pressed():
	OS.shell_open("https://2022.alexandre.backhub.fr/web/galakanoid")
