extends Control


func _on_weapon_1_pressed():
	GlobalVariables.weapon = "sword"
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
func _on_weapon_2_pressed():
	GlobalVariables.weapon = "axe"
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
