extends Node2D

var level
@onready var forest1 = preload("res://Scenes/Levels/level_1.tscn")
@onready var forest2 = preload("res://Scenes/Levels/level_2.tscn")

@onready var player: CharacterBody2D = $"../Player"
@onready var player_start_position

func _ready():
	if GlobalVariables.level == "forest1":
		level = forest1.instantiate()
	elif GlobalVariables.level == "forest2":
		level = forest2.instantiate()
	add_child(level)
	_setup_level() 

func _setup_level():
	player_start_position = get_child(0)._get_player_start_point()
	player.global_position = player_start_position.global_position
	print("in setup level")
