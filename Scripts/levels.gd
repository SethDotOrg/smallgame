extends Node2D


@onready var player: CharacterBody2D = $"../Player"
@onready var player_start_position = $Level1/StartPosition

#@export var enemy_1_scene: PackedScene
#
#@onready var enemy_spawn_location_1 = $"../Enemies/EnemySpawnLocation1"
#@onready var enemy_spawn_location_2 = $"../Enemies/EnemySpawnLocation2"
#@onready var enemy_spawn_location_3 = $"../Enemies/EnemySpawnLocation3"
#@onready var enemy_spawn_location_4 = $"../Enemies/EnemySpawnLocation4"
#
#@onready var gather_point_1 = $"../GatherPoints/GatherPoint"
#@onready var gather_point_2 = $"../GatherPoints/GatherPoint2"
#var num_of_enemy_1_to_spawn: int
#var enemy_1_count: int = 0
#
func _ready():
	player.global_position = player_start_position.global_position
	#num_of_enemy_1_to_spawn = gather_point_1.MAX_ENEMIES_FOR_GATHER_POINT + gather_point_2.MAX_ENEMIES_FOR_GATHER_POINT
#
#func _on_enemy_spawn_timer_timeout():
	#if enemy_1_count <  num_of_enemy_1_to_spawn:
		#var spawned_enemy = false
		## Create a new instance of the Mob scene.
		#var enemy = enemy_1_scene.instantiate()
#
		## Choose a random location on Path2D.
		#var enemy_spawn_point_num = randi_range(1,4)
		#var enemy_spawn_location
		#if enemy_spawn_point_num == 1:
			#enemy_spawn_location = enemy_spawn_location_1
		#elif enemy_spawn_point_num == 2:
			#enemy_spawn_location = enemy_spawn_location_2
		#elif enemy_spawn_point_num == 3:
			#enemy_spawn_location = enemy_spawn_location_3
		#elif enemy_spawn_point_num == 4:
			#enemy_spawn_location = enemy_spawn_location_4
		#
		#var enemy_gather_point_num = randi_range(1,2)
		#if enemy_gather_point_num == 1 and gather_point_1.check_assigned_enemy_num():
			#gather_point_1.update_assigned_enemy_num()
			#enemy.set_gather_point(gather_point_1)
			#spawned_enemy = true
		#elif enemy_gather_point_num == 2 and gather_point_2.check_assigned_enemy_num():
			#gather_point_2.update_assigned_enemy_num()
			#enemy.set_gather_point(gather_point_2)
			#spawned_enemy = true
#
		## Set the enemy's position to the random location around the spawn
		#enemy.position = enemy_spawn_location.position + Vector2(randf_range(-30,30),randf_range(-30,30))
#
		## Choose the speed for the enemy.
		#var speed = randf_range(40.0, 70.0) #and this when following player?
		#enemy.set_enemy_speed(speed)
		#
		## Spawn the enemy by adding it to the Main scene.
		#if spawned_enemy == true:
			#add_child(enemy)
			#enemy_1_count = enemy_1_count + 1
