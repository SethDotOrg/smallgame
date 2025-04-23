extends CharacterBody2D


@onready var target_position = get_gather_point().global_position

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#func _get_enemy_rigid_body():
	#return get_node("RigidBody2D")
	
func _physics_process(delta):
	#var enemy_direction = self.global_position.direction_to(gather_point.global_position) #get the direction from the enemy touched by to the player
	velocity = global_position.direction_to(target_position) * get_enemy_speed()
	move_and_slide()
	

func get_gather_point():
	return get_parent().gather_point

func get_enemy_speed():
	return get_parent().speed

func set_target_position(target: Vector2):
	target_position = target

func set_target_position_to_gather_point():
	set_target_position(get_gather_point().global_position)

#CHANGE THESE TO be from the player enemy check
#func _on_player_area_check_area_entered(area):
	#target_position = area.global_position
#func _on_player_area_check_area_exited(area):
	#target_position = get_spawner_princess().global_position
