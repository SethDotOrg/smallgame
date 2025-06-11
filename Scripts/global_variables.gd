extends Node


var score = 0 
var player_attacking:bool = false
var last_attack_direction: Vector2

#level selections
var level: String
var weapon: String

#player upgrades
var health: int

func update_score_ui():
	var UI = get_node("../Game/UI")
	UI.get_score_ui().update_score()
