extends Node2D


@onready var player: CharacterBody2D = $"../Player"
@onready var player_start_position = $Level1/StartPosition

func _ready():
	_setup_level() 

func _setup_level():
	player.global_position = player_start_position.global_position
	print("in setup level")
