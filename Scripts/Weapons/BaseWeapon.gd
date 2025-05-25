class_name BaseWeapon
extends Node2D

@export var slash_particle: Sprite2D

@onready var animation_player_weapon = $AnimationPlayerWeapon
@onready var pivot_point = $PivotPoint
	
func _physics_process(delta):
	
	#check to see the input and if the player is attacking
	if Input.is_action_just_pressed("attack_right") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		pivot_point.rotation = deg_to_rad(90)
		animation_player_weapon.play("Attack1")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("attack_left") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		pivot_point.rotation = deg_to_rad(270)
		animation_player_weapon.play("Attack1")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("attack_down") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		pivot_point.rotation = deg_to_rad(180)
		animation_player_weapon.play("Attack1")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("attack_up") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		pivot_point.rotation = deg_to_rad(0)
		animation_player_weapon.play("Attack1")
		await animation_player_weapon.animation_finished
		GlobalVariables.player_attacking = false
	
#handle sword attack. We need a system that will abstract some of this
func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill_enemy(self.global_position)
		body.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		GlobalVariables.update_score_ui()
