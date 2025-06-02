extends CharacterBody2D

@onready var enemy_parent_node = $".."
@onready var animation_player = $"../AnimationPlayer"
@onready var target_position = get_gather_point().global_position

@export var death_smoke_particle_scene: PackedScene
@export var blood_splatter_scene: PackedScene
	
func _physics_process(delta):
	velocity = global_position.direction_to(target_position) * get_enemy_speed() #calculate velocity with this enemies speed
	move_and_slide() #move and slide is one of the choices for character body's to move 
	
func get_gather_point():
	return get_parent().gather_point

func get_enemy_speed():
	return get_parent().speed

func set_target_position(target: Vector2):
	target_position = target

func set_target_position_to_gather_point():
	set_target_position(get_gather_point().global_position)

func kill_enemy(player_position:Vector2):
	#handle death
	enemy_parent_node.global_position = self.global_position
	animation_player.play("death")
	#handle smoke
	var death_smoke_particle = death_smoke_particle_scene.instantiate()
	death_smoke_particle.global_position = enemy_parent_node.global_position
	death_smoke_particle.emitting = true
	get_tree().current_scene.add_child(death_smoke_particle)
	#handle blood
	var blood_splatter = blood_splatter_scene.instantiate()
	blood_splatter.global_position = enemy_parent_node.global_position
	blood_splatter.rotation = player_position.angle_to_point(enemy_parent_node.global_position) #get the angle from player to enemy killed. blood splatter follows that line
	blood_splatter.emitting = true
	get_tree().current_scene.add_child(blood_splatter)
	
	#self.visible=false
	#if death_smoke_particle.finished:
		#get_parent().queue_free()
