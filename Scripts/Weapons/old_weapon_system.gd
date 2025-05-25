extends Node2D

@export var _weapon_animation_player: AnimationPlayer

@onready var sword_up = $Weapon/SwordUp
@onready var sword_down = $Weapon/SwordDown
@onready var sword_left = $Weapon/SwordLeft
@onready var sword_right = $Weapon/SwordRight
@onready var _player_sprite = $AnimatedSprite2D

func _physics_process(delta):

#check to see the input and if the player is attacking
	if Input.is_action_just_pressed("attack_right") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		_weapon_animation_player.play("sword_right_animation")
		await _weapon_animation_player.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("attack_left") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		_weapon_animation_player.play("sword_left_animation")
		await _weapon_animation_player.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("attack_down") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		_weapon_animation_player.play("sword_down_animation")
		await _weapon_animation_player.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("attack_up") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		_weapon_animation_player.play("sword_up_animation")
		await _weapon_animation_player.animation_finished
		GlobalVariables.player_attacking = false
	

#handle sword attack. We need a system that will abstract some of this
func _on_sword_up_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill_enemy(self.global_position)
		body.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		#_score_ui.update_score()
		check_score_for_sword()
func _on_sword_down_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill_enemy(self.global_position)
		body.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		#_score_ui.update_score()
		check_score_for_sword()
func _on_sword_left_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill_enemy(self.global_position)
		body.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		#_score_ui.update_score()
		check_score_for_sword()
func _on_sword_right_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill_enemy(self.global_position)
		body.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		#_score_ui.update_score()
		check_score_for_sword()

func check_score_for_sword(): #this is temp for upgrading the sword
	if GlobalVariables.score == 10 or GlobalVariables.score == 50 or GlobalVariables.score == 100:
		sword_up.scale.x += 1
		sword_up.scale.y += 1
		sword_down.scale.x += 1
		sword_down.scale.y += 1
		sword_left.scale.x += 1
		sword_left.scale.y += 1
		sword_right.scale.x += 1
		sword_right.scale.y += 1
		_weapon_animation_player.speed_scale -= 0.2
