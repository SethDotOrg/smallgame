extends Node2D

@export var MAX_ENEMIES_FOR_GATHER_POINT: int
var enemies_on_gather_point:int = 0

func _process(delta):
	print("there are: ",enemies_on_gather_point," at ", self.name)

func check_assigned_enemy_num():
	return enemies_on_gather_point < MAX_ENEMIES_FOR_GATHER_POINT

func update_assigned_enemy_num():
	enemies_on_gather_point = enemies_on_gather_point + 1
