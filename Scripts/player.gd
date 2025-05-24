class_name Player
extends CharacterBody2D

signal hit

@export var _base_ui: Control
@export var _weapon_animation_player: AnimationPlayer
@export var _AP_Hit_Flash: AnimationPlayer
@export var speed = 125 # How fast the player will move (pixels/sec).
@export var HEALTH = 3 + GlobalVariables.health

@onready var sword_up = $Weapon/SwordUp
@onready var sword_down = $Weapon/SwordDown
@onready var sword_left = $Weapon/SwordLeft
@onready var sword_right = $Weapon/SwordRight
@onready var _player_sprite = $AnimatedSprite2D
@onready var _enemy_check_collision_shape = $EnemyCheckArea2D/EnemyCollisionShape2D
@onready var _state_machine = $PlayerStateMachine

@onready var _area_for_enemy_follow_timer = $AreaForEnemyFollow/AreaDisabledTimer
@onready var _enemy_follow_collision_shape = $AreaForEnemyFollow/EnemyFollowCollisionShape
@onready var _allow_hit_timer = $AllowHitTimer

var _score_ui
var _game_over_ui
var _health_ui

var health: int

func _change_weapon(): #TEMPORARY
	if GlobalVariables.weapon == "sword":
		sword_up.texture = load("res://Sprites/weapons/sword/sword1.png")
		sword_down.texture = load("res://Sprites/weapons/sword/sword1.png")
		sword_left.texture = load("res://Sprites/weapons/sword/sword1.png")
		sword_right.texture = load("res://Sprites/weapons/sword/sword1.png")
	elif GlobalVariables.weapon == "axe":
		sword_up.texture = load("res://Sprites/weapons/axe/axe1.png")
		sword_down.texture = load("res://Sprites/weapons/axe/axe1.png")
		sword_left.texture = load("res://Sprites/weapons/axe/axe1.png")
		sword_right.texture = load("res://Sprites/weapons/axe/axe1.png")


func _ready():
	_state_machine.init(self)
	_score_ui = _base_ui.get_score_ui()
	_game_over_ui = _base_ui.get_game_over_ui()
	_health_ui = _base_ui.get_health_ui()
	health = HEALTH
	_health_ui._set_health(health)
	_change_weapon()
	
func _unhandled_input(event: InputEvent):
	_state_machine.process_input(event)

func _process(delta: float):
	_state_machine.process_frame(delta)
	
func _physics_process(delta):
	_state_machine.process_physics(delta)
	
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
		_score_ui.update_score()
		check_score_for_sword()
func _on_sword_down_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill_enemy(self.global_position)
		body.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		_score_ui.update_score()
		check_score_for_sword()
func _on_sword_left_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill_enemy(self.global_position)
		body.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		_score_ui.update_score()
		check_score_for_sword()
func _on_sword_right_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill_enemy(self.global_position)
		body.get_gather_point().decrease_assigned_enemies_num()
		GlobalVariables.score += 1
		_score_ui.update_score()
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

func _on_area_for_enemy_follow_body_entered(body):#when enemy enters the enemy follow area 2d set the enemy follow point to the player
	if body.is_in_group("Enemy"):
		body.set_target_position(self.global_position)
		#print("body entered")
func _on_area_for_enemy_follow_body_exited(body):#after a second when the enemy leaves the follow area 2d set the follow point position to enemies assigned gather point
	if body.is_in_group("Enemy"):
		await get_tree().create_timer(1.0).timeout #seconds
		if body != null:
			body.set_target_position_to_gather_point()

func _on_area_disabled_timer_timeout():#turn on and off the area2d to check for enemies so that they will follow the player as the player moves
	_enemy_follow_collision_shape.disabled = !_enemy_follow_collision_shape.disabled
	_area_for_enemy_follow_timer.start()


func _on_enemy_check_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		#push the player back in the direction the enemy was moving
		handle_hurt_box()
		var knockback_direction = body.global_position.direction_to(self.global_position) #get the direction from the enemy touched by to the player
		self.global_position += knockback_direction * 40 #move the player back in that direction by a strength
		if _allow_hit_timer.time_left <=0:
			print("hit timer")
			#set health
			health = health - 1
			_health_ui._set_health(health)
		_allow_hit_timer.start()
	# Must be deferred as we can't change physics properties on a physics callback.
	_enemy_check_collision_shape.set_deferred("disabled", true) #basically turn off the collision shape so we dont get more then one input at the end of the frame
func _on_enemy_check_area_2d_body_exited(body):
	_enemy_check_collision_shape.set_deferred("disabled", false)

func handle_hurt_box():
	#play animation for hit flash
	_AP_Hit_Flash.play("HitFlash")
	#then while that animation plays, the player will be invincible to enemy attacks
	_enemy_check_collision_shape.disabled = true
	await get_tree().create_timer(_AP_Hit_Flash.current_animation_length).timeout
	_enemy_check_collision_shape.disabled = false
