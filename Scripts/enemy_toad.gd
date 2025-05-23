extends Node2D

@export var enemy_1_scene: PackedScene #keep to give to enemies for level script
@export var ememy_1_appear_smoke: PackedScene
var parent
var num_of_gather_points: int

func _ready():
	parent = get_parent()
	num_of_gather_points = parent._get_num_of_gather_points()

#below should be moved to script that takes care of just enemy X
func _spawn_enemy_at_random_gather_point(enemy_count: int, num_of_enemy_to_spawn: int):
	var spawned_enemy = false
	if enemy_count <  num_of_enemy_to_spawn:
		# Create a new instance of the Mob scene.
		var enemy = enemy_1_scene.instantiate()
		var enemy_spawn_location
		var enemy_gather_point_num = randi_range(1, num_of_gather_points)
		if enemy_gather_point_num == 1 and parent.gather_point_1.check_assigned_enemy_1_num() and parent.gather_point_1.check_assigned_enemies():
			parent.gather_point_1.update_assigned_enemy_1_num()
			enemy.set_gather_point(parent.gather_point_1)
			spawned_enemy = true
			enemy_spawn_location = parent.gather_point_1.global_position
		elif enemy_gather_point_num == 2 and parent.gather_point_2.check_assigned_enemy_1_num() and parent.gather_point_2.check_assigned_enemies():
			parent.gather_point_2.update_assigned_enemy_1_num()
			enemy.set_gather_point(parent.gather_point_2)
			spawned_enemy = true
			enemy_spawn_location = parent.gather_point_2.global_position
		
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
			return spawned_enemy #will be true if returned here
	return spawned_enemy #false if returned here
