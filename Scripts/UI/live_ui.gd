extends Control

@onready var retry_button: Button = $GameOver/Retry
#@onready var main_menu_button: Button = $GameOver/MainMenu

func get_score_ui():
	return get_node("Score")
func get_game_over_ui():
	return get_node("GameOver")
func get_health_ui():
	return get_node("Health")

func _on_game_time_timeout():
	_handle_game_over()
func _on_health_health_hits_zero():
	_handle_game_over()

func _handle_game_over():
	GlobalVariables.can_pause = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_game_over_ui().visible = true
	get_tree().paused = true
	retry_button.grab_focus()


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	GlobalVariables.can_pause = true
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
