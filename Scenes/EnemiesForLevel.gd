extends Node2D

#add more exports for enemies as needed per level
@export var enemy1: Node2D

@export var num_of_gather_points: int
@onready var gather_point_1 = $"../GatherPoints/GatherPoint"
@onready var gather_point_2 = $"../GatherPoints/GatherPoint2"
var num_of_enemy_1_to_spawn: int
var enemy_1_count: int = 0

func _ready():
	num_of_enemy_1_to_spawn = gather_point_1.ENEMY_1_MAX + gather_point_2.ENEMY_1_MAX

func _get_num_of_gather_points():
	return num_of_gather_points
func _get_gather_point_1():
	return gather_point_1
func _get_gather_point_2():
	return gather_point_2

func _get_num_of_enemy_1_spawn():
	return num_of_enemy_1_to_spawn

func _on_enemy_toad_spawn_timer_timeout():
	enemy1._spawn_enemy_at_random_gather_point(enemy_1_count, num_of_enemy_1_to_spawn)
	enemy_1_count = enemy_1_count + 1
