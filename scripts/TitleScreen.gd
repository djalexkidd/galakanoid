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

# CHEAT CODE

const MAX_LENGTH := 32

# Dictionary of key scancodes used in cheat codes, and their alphanumeric representation.
const CODE_KEYS := {
	KEY_SPACE:" ", KEY_APOSTROPHE:"'", KEY_COMMA:",", KEY_MINUS:"-", KEY_PERIOD:".", KEY_SLASH:"/",
	KEY_0:"0", KEY_1:"1", KEY_2:"2", KEY_3:"3", KEY_4:"4", KEY_5:"5", KEY_6:"6", KEY_7:"7", KEY_8:"8", KEY_9:"9",
	KEY_SEMICOLON:";", KEY_EQUAL:"=",

	KEY_A:"a", KEY_B:"b", KEY_C:"c", KEY_D:"d", KEY_E:"e", KEY_F:"f", KEY_G:"g", KEY_H:"h", KEY_I:"i",
	KEY_J:"j", KEY_K:"k", KEY_L:"l", KEY_M:"m", KEY_N:"n", KEY_O:"o", KEY_P:"p", KEY_Q:"q", KEY_R:"r",
	KEY_S:"s", KEY_T:"t", KEY_U:"u", KEY_V:"v", KEY_W:"w", KEY_X:"x", KEY_Y:"y", KEY_Z:"z",

	KEY_BRACELEFT:"[", KEY_BACKSLASH:"\\", KEY_BRACERIGHT:"]", KEY_QUOTELEFT:"`"
}
# List of cheat codes. Cheat codes should be lower-case, and should not be contained within one another or the shorter
# cheat code will take precedence.
export (Array, String) var codes := ["prout"]
# Buffer of key strings which were previously pressed.
var _previous_keypresses: String = ""

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.scancode in CODE_KEYS:
		var key_string: String = CODE_KEYS[event.scancode]
		if event.pressed and not event.is_echo():
			_key_just_pressed(key_string)

func _key_just_pressed(key_string: String) -> void:
	_previous_keypresses += key_string
	# remove the oldest keypresses so the buffer doesn't grow infinitely
	_previous_keypresses = _previous_keypresses.right(_previous_keypresses.length() - MAX_LENGTH)
	for code in codes:
		if code == _previous_keypresses.right(_previous_keypresses.length() - code.length()):
			# Clear the keypress buffer, otherwise a keypress could count towards two different cheats
			_previous_keypresses = ""
			Global.fart_mode = true
			$FartMode.play()
