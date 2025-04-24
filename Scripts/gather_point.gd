extends Node2D

@export var ENEMY_1_MAX: int
var enemy_1_on_gather_point:int = 0

func _process(delta):
	print("there are: ",enemy_1_on_gather_point," at ", self.name)
	pass
	
func check_assigned_enemy_1_num():
	return enemy_1_on_gather_point < ENEMY_1_MAX

func update_assigned_enemy_1_num():
	enemy_1_on_gather_point = enemy_1_on_gather_point + 1
