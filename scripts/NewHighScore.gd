extends Control

func _ready():
	$GridContainer/ScoreLabel2.text = str(Global.last_score)
	$GridContainer/LevelLabel2.text = str(Global.last_level)
	Global.highscore = Global.last_score

func _make_post_request(url, data_to_send, use_ssl):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)

func _on_SendButton_pressed():
	if $GridContainer/NameEdit.get_text() != "":
		$SendButton.hide()
		$SendingLabel.show()
		_make_post_request("https://2022.alexandre.backhub.fr/sendscore?apikey=0", {"name": $GridContainer/NameEdit.get_text(), "score": Global.last_score}, false)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
