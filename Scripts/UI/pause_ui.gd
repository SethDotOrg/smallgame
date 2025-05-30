extends Control

@onready var _resume_button = $PauseOptions/Resume
@onready var _options_button = $PauseOptions/Options
@onready var _exit_main_menu_button = $PauseOptions/ExitToMainMenu
@onready var _pause_options_group = $PauseOptions
@onready var _options_menu_group = $OptionsMenu
@onready var _audio_menu_group = $AudioMenu

var _base_ui

func _ready():
	_resume_button.grab_focus()
	_base_ui = get_parent().get_parent()# first parent is canvas layer then base ui

func _on_resume_pressed():
	_base_ui.handle_game_resume()
func _on_options_pressed():
	_pause_options_group.visible = false
	_options_menu_group.visible = true
	_audio_menu_group.visible = false
func _on_exit_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
	GlobalVariables.player_attacking = false


func _on_back_button_main_menu_pressed():
	_pause_options_group.visible = true
	_options_menu_group.visible = false
	_audio_menu_group.visible = false
func _on_audio_options_pressed():
	_pause_options_group.visible = false
	_options_menu_group.visible = false
	_audio_menu_group.visible = true


func _on_back_button_to_options_menu_pressed():
	_pause_options_group.visible = false
	_options_menu_group.visible = true
	_audio_menu_group.visible = false
