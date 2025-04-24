extends Node2D


@onready var player: CharacterBody2D = $"../Player"
@onready var player_start_position = $Level1/StartPosition

func _ready():
	player.global_position = player_start_position.global_position
