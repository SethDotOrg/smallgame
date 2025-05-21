extends Control

@onready var _health_value_bar = $CanvasLayer/AudioMenu/Health/ProgressBar

var health_value

func _ready():
	health_value = GlobalVariables.health

func _on_back_button_to_options_menu_pressed():
	#back to main menu
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
func _on_plus_pressed():
	health_value = health_value + 1
	GlobalVariables.health = health_value
	_health_value_bar.value = health_value
	print("HEALTH: ",GlobalVariables.health)
