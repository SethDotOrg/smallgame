extends Control


func _on_level_1_pressed():
	GlobalVariables.level = "forest1"
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
func _on_level_2_pressed():
	GlobalVariables.level = "forest2"
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
