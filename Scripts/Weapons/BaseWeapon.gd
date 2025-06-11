class_name BaseWeapon
extends Node2D

@export_category("Setters")
@export var slash_particle: Sprite2D
@export var weapon_hit_spark_scene : PackedScene
@export var tip_of_weapon: Marker2D
@export var weapon_collision_shape_1: CollisionShape2D
@export var player_speed: int = 125

@export_category("Weapon Properties")
@export var force_of_attack: float = 100
@export var knockback_duration: float = 2
@export var weapon_spd_s_atk_1: float = 1
@export var weapon_spd_s_atk_2: float = 1

@onready var animation_player_weapon = $AnimationPlayerWeapon
@onready var pivot_point = $PivotPoint
@onready var hit_spark_sound = $WeaponHitSparkSound

func _ready():
	get_parent().set_player_speed(player_speed)

func _physics_process(delta):
	#check to see the input and if the player is attacking for attack animation 1
	if !Input.is_action_pressed("secondary_attack") and Input.is_action_just_pressed("attack_right") and GlobalVariables.player_attacking == false:
		animation_player_weapon.speed_scale = weapon_spd_s_atk_1
		GlobalVariables.player_attacking = true
		GlobalVariables.last_attack_direction = Vector2.RIGHT
		pivot_point.rotation = deg_to_rad(90)
		animation_player_weapon.play("Attack1")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if !Input.is_action_pressed("secondary_attack") and Input.is_action_just_pressed("attack_left") and GlobalVariables.player_attacking == false:
		animation_player_weapon.speed_scale = weapon_spd_s_atk_1
		GlobalVariables.player_attacking = true
		GlobalVariables.last_attack_direction = Vector2.LEFT
		pivot_point.rotation = deg_to_rad(270)
		animation_player_weapon.play("Attack1")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if !Input.is_action_pressed("secondary_attack") and Input.is_action_just_pressed("attack_down") and GlobalVariables.player_attacking == false:
		animation_player_weapon.speed_scale = weapon_spd_s_atk_1
		GlobalVariables.player_attacking = true
		GlobalVariables.last_attack_direction = Vector2.DOWN
		pivot_point.rotation = deg_to_rad(180)
		animation_player_weapon.play("Attack1")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if !Input.is_action_pressed("secondary_attack") and Input.is_action_just_pressed("attack_up") and GlobalVariables.player_attacking == false:
		animation_player_weapon.speed_scale = weapon_spd_s_atk_1
		GlobalVariables.player_attacking = true
		GlobalVariables.last_attack_direction = Vector2.UP
		pivot_point.rotation = deg_to_rad(0)
		animation_player_weapon.play("Attack1")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	
	#check to see the input and if the player is attacking for attack animation 2
	if Input.is_action_pressed("secondary_attack") and Input.is_action_just_pressed("attack_right") and GlobalVariables.player_attacking == false:
		animation_player_weapon.speed_scale = weapon_spd_s_atk_2
		GlobalVariables.player_attacking = true
		GlobalVariables.last_attack_direction = Vector2.RIGHT
		pivot_point.rotation = deg_to_rad(90)
		animation_player_weapon.play("Attack2")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_pressed("secondary_attack") and Input.is_action_just_pressed("attack_left") and GlobalVariables.player_attacking == false:
		animation_player_weapon.speed_scale = weapon_spd_s_atk_2
		GlobalVariables.player_attacking = true
		GlobalVariables.last_attack_direction = Vector2.LEFT
		pivot_point.rotation = deg_to_rad(270)
		animation_player_weapon.play("Attack2")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_pressed("secondary_attack") and Input.is_action_just_pressed("attack_down") and GlobalVariables.player_attacking == false:
		animation_player_weapon.speed_scale = weapon_spd_s_atk_2
		GlobalVariables.player_attacking = true
		GlobalVariables.last_attack_direction = Vector2.DOWN
		pivot_point.rotation = deg_to_rad(180)
		animation_player_weapon.play("Attack2")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_pressed("secondary_attack") and Input.is_action_just_pressed("attack_up") and GlobalVariables.player_attacking == false:
		animation_player_weapon.speed_scale = weapon_spd_s_atk_2
		GlobalVariables.player_attacking = true
		GlobalVariables.last_attack_direction = Vector2.UP
		pivot_point.rotation = deg_to_rad(0)
		animation_player_weapon.play("Attack2")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	
#handle sword attack
func _on_area_2d_area_entered(area):
	if area.is_in_group("EnemyHitbox"):
		#handle enemy knockback
		area.get_enemy_body().apply_knockback(GlobalVariables.last_attack_direction, force_of_attack, knockback_duration)
		
		area.kill_enemy(self.global_position)
		handle_hit_particle(area.global_position)
		area.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		GlobalVariables.update_score_ui()
		#var knockback_direction = (area.global_position - get_parent().get_parent().global_position).normalized()
		## Must be deferred as we can't change physics properties on a physics callback.
		#weapon_collision_shape_1.set_deferred("disabled", true) #basically turn off the collision shape so we dont get more then one input at the end of the frame

func _on_area_2d_area_exited(area):
	#weapon_collision_shape_1.set_deferred("disabled", false)
	pass

func handle_hit_particle(hit_position:Vector2):
	#handle weapon hit spark
	var weapon_hit_spark = weapon_hit_spark_scene.instantiate()
	weapon_hit_spark.global_position = tip_of_weapon.global_position
	weapon_hit_spark.rotation = hit_position.angle_to_point(tip_of_weapon.global_position) #get the angle from player to enemy killed. blood splatter follows that line
	weapon_hit_spark.emitting = true
	get_tree().current_scene.add_child(weapon_hit_spark)
	hit_spark_sound.playing = true
