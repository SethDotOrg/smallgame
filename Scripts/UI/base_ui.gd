extends Control

@onready var _live_ui = $CanvasLayer/LiveUI
@onready var _pause_ui = $CanvasLayer/PauseUI

var current_state

enum MENU_STATES {LIVE_STATE, PAUSE_STATE, OPTIONS_STATE, SOUND_OPTIONS_STATE, CONTROL_OPTIONS_STATE}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #captured mouse will hide the cursor
	current_state = MENU_STATES.LIVE_STATE

func _unhandled_input(_event):
	if Input.is_action_just_pressed("pause") and current_state == MENU_STATES.LIVE_STATE:
		print("pause in live")
		_ui_hide_switch()
		await get_tree().create_timer(0.1).timeout #seconds 
		current_state = MENU_STATES.PAUSE_STATE
		get_tree().paused = true #pause the game but not the things marked as not being able to in the inspector
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) #this allows the mouse to be seen :>
	if Input.is_action_just_pressed("pause") and current_state == MENU_STATES.PAUSE_STATE:
		print("pause in pause")
		handle_game_resume()

func handle_game_resume():
	print("handle resume")
	await get_tree().create_timer(0.1).timeout #seconds
	current_state = MENU_STATES.LIVE_STATE
	get_tree().paused = false
	_ui_hide_switch()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_score_ui():
	return _live_ui.get_score_ui()
func get_game_over_ui():
	return _live_ui.get_game_over_ui()
func get_health_ui():
	return _live_ui.get_health_ui()

func _ui_hide_switch():
	_live_ui.visible = !_live_ui.visible
	_pause_ui.visible = !_pause_ui.visible
