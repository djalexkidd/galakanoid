extends Node

var credits = 0
var mouse
var fart_mode
var highscore = 0

var last_score = 0
var last_level = 0

func _ready():
	load_highscore()

#Cette fonction charge le meilleur temps
#Sous GNU/Linux le fichier se situe dans /home/$USER/.local/share/godot/app_userdata/Galakanoid/
func load_highscore():
	var save_file = File.new()
	if not save_file.file_exists("user://highscore.json"):
		return #Ne fait rien si le fichier n'existe pas

	save_file.open("user://highscore.json", File.READ) #Ouvre le fichier
	var json_str = save_file.get_as_text()
	var game_data = JSON.parse(json_str).result
	Global.highscore = game_data.highscore #Met la première ligne du fichier dans une variable "highscore"
	save_file.close() #Ferme le fichier
