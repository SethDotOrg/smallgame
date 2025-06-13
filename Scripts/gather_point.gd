extends Node2D

@onready var _time_to_clear = $CheckForPlayerArea2D/TimeToClear
@onready var enemy_spawn_timer = $EnemySpawnTimer

#@export var ENEMY_MAX = 150 #total amount of enemies allowed on a gather point(preformance)
var ENEMY_MAX #total amount of enemies allowed on a gather point(preformance)
var total_gather_point_enemies = 0
var total_enemies_used: int

@export var enemy_spawn_time: float = 0.01
@export_category("Enemy 1")
var enemy_1_on_gather_point:int = 0
@export var ENEMY_1_TOTAL: int = 0
var enemy_1_count = 0
@export var enemy_1_scene: PackedScene
@export var ememy_1_appear_smoke: PackedScene
@export_category("Enemy 2")
var enemy_2_on_gather_point:int = 0
@export var ENEMY_2_TOTAL: int = 0
var enemy_2_count
@export var enemy_2_scene: PackedScene
@export var ememy_2_appear_smoke: PackedScene
@export_category("Enemy 3")
var enemy_3_on_gather_point:int = 0
@export var ENEMY_3_TOTAL: int = 0
var enemy_3_count
@export var enemy_3_scene: PackedScene
@export var ememy_3_appear_smoke: PackedScene
@export_category("Enemy 4")
var enemy_4_on_gather_point:int = 0
@export var ENEMY_4_TOTAL: int = 0
var enemy_4_count
@export var enemy_4_scene: PackedScene
@export var ememy_4_appear_smoke: PackedScene
@export_category("Enemy 5")
var enemy_5_on_gather_point:int = 0
@export var ENEMY_5_TOTAL: int = 0
var enemy_5_count
@export var enemy_5_scene: PackedScene
@export var ememy_5_appear_smoke: PackedScene
@export_category("Enemy 6")
var enemy_6_on_gather_point:int = 0
@export var ENEMY_6_TOTAL: int = 0
var enemy_6_count
@export var enemy_6_scene: PackedScene
@export var ememy_6_appear_smoke: PackedScene
@export_category("Enemy 7")
var enemy_7_on_gather_point:int = 0
@export var ENEMY_7_TOTAL: int = 0
var enemy_7_count
@export var enemy_7_scene: PackedScene
@export var ememy_7_appear_smoke: PackedScene

signal enemies_defeated

func _ready():
	enemy_spawn_timer.wait_time = enemy_spawn_time
	ENEMY_MAX = ENEMY_1_TOTAL + ENEMY_2_TOTAL + ENEMY_3_TOTAL + ENEMY_4_TOTAL + ENEMY_5_TOTAL + ENEMY_6_TOTAL + ENEMY_7_TOTAL
	if enemy_1_scene != null:
		total_enemies_used += 1
	if enemy_2_scene != null:
		total_enemies_used += 1
	if enemy_3_scene != null:
		total_enemies_used += 1
	if enemy_4_scene != null:
		total_enemies_used += 1
	if enemy_5_scene != null:
		total_enemies_used += 1
	if enemy_6_scene != null:
		total_enemies_used += 1
	if enemy_7_scene != null:
		total_enemies_used += 1

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
	GlobalVariables.score = GlobalVariables.score + calculate_score() #add remaining seconds as score 
	#TODO make a formula for more interesting score addition

func calculate_score():
	var score
	if (_time_to_clear._get_timer_for_score() / _time_to_clear.starting_time) >= 0.75:
		score = _time_to_clear._get_timer_for_score() * 2.3
		ceili(score)
		print("percent used: ",0.75, "multiplied by 2.3")
	elif (_time_to_clear._get_timer_for_score() / _time_to_clear.starting_time) >= 0.50:
		score = _time_to_clear._get_timer_for_score() * 1.7
		ceili(score)
		print("percent used: ",0.50, "multiplied by 1.7")
	elif (_time_to_clear._get_timer_for_score() / _time_to_clear.starting_time) >= 0.25:
		score = _time_to_clear._get_timer_for_score() * 1.3
		ceili(score)
		print("percent used: ",0.25, "multiplied by 1.3")
	else:
		score = _time_to_clear._get_timer_for_score()
		print("percent used: ",0, "multiplied by 1")
	print("score sending back: ", score)
	return score


func _on_enemy_spawn_timer_timeout():
	var spawned_enemy = false
	#Choose which enemy to spawn
	#WRITE CODE HERE for above
	var chosen_enemy = randi_range(0,total_enemies_used) # this should choose
	if chosen_enemy == 0 and enemy_1_count <  ENEMY_1_TOTAL:
		# Create a new instance of the Mob scene.
		var enemy = enemy_1_scene.instantiate()
		var enemy_spawn_location
		if check_assigned_enemy_1_num() and check_assigned_enemies():
			update_assigned_enemy_1_num()
			enemy.set_gather_point(self)
			spawned_enemy = true
			enemy_spawn_location = self.global_position
		
		if spawned_enemy == true:
			var enemy_appear_smoke = ememy_1_appear_smoke.instantiate()
			enemy_appear_smoke.emitting = true
			# Set the enemy's position to the random location around the spawn so that they don't spawn at the same coords
			var enemy_spawn_position = enemy_spawn_location + Vector2(randf_range(-500,500),randf_range(-500,500))
			enemy.global_position = enemy_spawn_position
			enemy_appear_smoke.global_position = enemy_spawn_position #spawn smoke should be at the same location
			
			# Choose the speed for the enemy.
			var speed = randf_range(40.0, 70.0)
			enemy.set_enemy_speed(speed)
			
			# Spawn the enemy by adding it as a child of self
			add_child(enemy)
			#spawn the smoke
			add_child(enemy_appear_smoke)
