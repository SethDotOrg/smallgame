extends Control

func get_score_ui():
	return get_node("Score")
func get_game_over_ui():
	return get_node("GameOver")
func get_health_ui():
	return get_node("Health")

func _on_game_time_timeout():
	get_game_over_ui().visible = true
	get_tree().paused = true
