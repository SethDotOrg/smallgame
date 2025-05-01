extends Node2D

#add more exports for enemies as needed per level
@export var enemy1: Node2D

@export var num_of_gather_points: int
@onready var gather_point_1 = $"../GatherPoints/GatherPoint"
@onready var gather_point_2 = $"../GatherPoints/GatherPoint2"
var num_of_enemy_1_to_spawn: int
var enemy_1_count: int = 0

func _ready():
	#get gather points and add the total enemies to spawn together so we know when to stop spawning them
	num_of_enemy_1_to_spawn = gather_point_1.ENEMY_1_TOTAL + gather_point_2.ENEMY_1_TOTAL

func _get_num_of_gather_points():
	return num_of_gather_points
func _get_gather_point_1():
	return gather_point_1
func _get_gather_point_2():
	return gather_point_2

func _get_num_of_enemy_1_spawn():
	return num_of_enemy_1_to_spawn

func _on_enemy_toad_spawn_timer_timeout():
	var worked = enemy1._spawn_enemy_at_random_gather_point(enemy_1_count, num_of_enemy_1_to_spawn)#if requirements met to
	#spawn the enemy
	if worked == true:
		enemy_1_count = enemy_1_count + 1 #then add to the count of total enemies (enemy 1 in this case. need more counters later)
