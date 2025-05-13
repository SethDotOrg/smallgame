extends Node2D

@onready var _levels = $Levels
@onready var _base_ui = $Ui

func _ready():
	_levels._setup_level()
	get_tree().paused = false
