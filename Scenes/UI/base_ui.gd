extends Control

func get_score_ui():
	return get_node("CanvasLayer/Score")
func get_game_over_ui():
	return get_node("CanvasLayer/GameOver")


func _on_game_time_timeout():
	get_game_over_ui().visible = true
	get_tree().paused = true
