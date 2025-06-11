extends Area2D

func kill_enemy(player_position:Vector2):
	get_parent().kill_enemy(player_position)

func get_gather_point():
	return get_parent().get_gather_point()

func get_enemy_speed():
	return get_parent().get_enemy_speed()

func set_target_position(target: Vector2):
	get_parent().set_target_position(target)

func set_target_position_to_gather_point():
	get_parent().set_target_position(get_gather_point().global_position)

func get_enemy_body():
	return get_parent()
