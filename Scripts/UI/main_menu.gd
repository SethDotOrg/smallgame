extends Control

@onready var _start_button = $CanvasLayer/VBoxContainer/Start
@onready var _options_button = $CanvasLayer/VBoxContainer/Options
@onready var _exit_button = $CanvasLayer/VBoxContainer/Exit

func _ready():
	#TranslationServer.set_locale("ja")
	_start_button.grab_focus()
	get_tree().paused = false


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/LevelSelect.tscn")
func _on_upgrades_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Upgrades.tscn")
func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/options_main_menu.tscn")
func _on_exit_pressed():
	get_tree().quit()
