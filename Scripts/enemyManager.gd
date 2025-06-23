extends Node2D

@export var gather_point: Node2D
var speed = 50
var enemy_number = 0

func set_gather_point(determined_gather_point):
	gather_point = determined_gather_point

func set_enemy_speed(determined_speed: float):
	speed = determined_speed

func set_enemy_number(enemy_num):
	enemy_number = enemy_num
func get_enemy_number():
	return enemy_number

func set_target_position(target: Vector2):
	$CharacterBody2D.set_target_position(target)

#func set_target_position_to_gather_point():
	#set_target_position(gather_point.global_position)
