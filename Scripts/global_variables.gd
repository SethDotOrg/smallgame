extends Node

var score = 0 
var player_attacking:bool = false

#level selections
var level: String
var weapon: String

#player upgrades
var health: int

@export var UI: Control
func update_score_ui():
	UI.get_score_ui().update_score()
