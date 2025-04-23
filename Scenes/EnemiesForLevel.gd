extends Node2D

#add more exports for enemies as needed per level
@export var enemy1: Node2D#this will be the node that take care of the spawning code in the future
@export var enemy_1_scene: PackedScene #this will be in ememy 1 node above

@onready var gather_point_1 = $"../GatherPoints/GatherPoint"
@onready var gather_point_2 = $"../GatherPoints/GatherPoint2"
var num_of_enemy_1_to_spawn: int #TODO make num per gather points adjustable in enemyX node. then it will be assigned a random gather point
var enemy_1_count: int = 0

func _ready():
	num_of_enemy_1_to_spawn = gather_point_1.MAX_ENEMIES_FOR_GATHER_POINT + gather_point_2.MAX_ENEMIES_FOR_GATHER_POINT

#below should be moved to script that takes care of just enemy 1
func _on_enemy_spawn_timer_timeout():
	if enemy_1_count <  num_of_enemy_1_to_spawn:
		var spawned_enemy = false
		# Create a new instance of the Mob scene.
		var enemy = enemy_1_scene.instantiate()

		var enemy_spawn_location
		var enemy_gather_point_num = randi_range(1,2)
		if enemy_gather_point_num == 1 and gather_point_1.check_assigned_enemy_num():
			gather_point_1.update_assigned_enemy_num()
			enemy.set_gather_point(gather_point_1)
			spawned_enemy = true
			enemy_spawn_location.global_position = gather_point_1.global_position
		elif enemy_gather_point_num == 2 and gather_point_2.check_assigned_enemy_num():
			gather_point_2.update_assigned_enemy_num()
			enemy.set_gather_point(gather_point_2)
			spawned_enemy = true
			enemy_spawn_location.global_position = gather_point_2.global_position

		# Set the enemy's position to the random location around the spawn
		enemy.position = enemy_spawn_location.position + Vector2(randf_range(-50,50),randf_range(-50,50))

		# Choose the speed for the enemy.
		var speed = randf_range(40.0, 70.0)
		enemy.set_enemy_speed(speed)
		
		# Spawn the enemy by adding it as a child of self
		if spawned_enemy == true:
			add_child(enemy)
			enemy_1_count = enemy_1_count + 1
