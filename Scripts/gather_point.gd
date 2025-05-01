extends Node2D

@onready var _time_to_clear = $CheckForPlayerArea2D/TimeToClear

var ENEMY_MAX = 150 #total amount of enemies allowed on a gather point(preformance)
var total_gather_point_enemies = 0
@export var ENEMY_1_TOTAL: int
var enemy_1_on_gather_point:int = 0

signal enemies_defeated

func _process(delta):
	#print("there are: ",enemy_1_on_gather_point," at ", self.name)
	pass

func check_assigned_enemies(): #check to see if total enimies for this gather point exceeds the max
	return total_gather_point_enemies < ENEMY_MAX
func increase_assigned_enemies_num():
	total_gather_point_enemies = total_gather_point_enemies + 1
func decrease_assigned_enemies_num():
	total_gather_point_enemies = total_gather_point_enemies - 1
	if total_gather_point_enemies == 0 and check_enemy_totals():
		print("IN EMIT: ", _time_to_clear._get_timer_for_score())
		enemies_defeated.emit() #emit for the signal. so any thing listening for it is hit

func check_enemy_totals():
	var enemy1 = enemy_1_on_gather_point == ENEMY_1_TOTAL
	return enemy1# and etc for more enemies

func check_assigned_enemy_1_num(): #check to see if enemy 1 spawned is less then the max
	return enemy_1_on_gather_point < ENEMY_1_TOTAL
func update_assigned_enemy_1_num():
	enemy_1_on_gather_point = enemy_1_on_gather_point + 1
	increase_assigned_enemies_num()


func _on_enemies_defeated():
	GlobalVariables.score = GlobalVariables.score + _time_to_clear._get_timer_for_score() #add remaining seconds as score 
	#TODO make a formula for more interesting score addition
