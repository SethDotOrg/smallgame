extends Control

@onready var _resume_button = $PauseOptions/Resume
@onready var _options_button = $PauseOptions/Options
@onready var _exit_main_menu_button = $PauseOptions/ExitToMainMenu

var _base_ui

func _ready():
	_resume_button.grab_focus()
	_base_ui = get_parent().get_parent()# first parent is canvas layer then base ui

func _on_resume_pressed():
	_base_ui.handle_game_resume()
func _on_exit_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
