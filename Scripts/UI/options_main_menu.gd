extends Control

@onready var options_menu_group = $CanvasLayer/OptionsMenu
@onready var audio_menu_group = $CanvasLayer/AudioMenu


func _on_audio_options_pressed():
	options_menu_group.visible = false
	audio_menu_group.visible = true


func _on_back_button_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
func _on_back_button_to_options_menu_pressed():
	options_menu_group.visible = true
	audio_menu_group.visible = false
