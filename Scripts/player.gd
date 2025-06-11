class_name Player
extends CharacterBody2D

signal hit

@export var _base_ui: Control
@export var _AP_Hit_Flash: AnimationPlayer
@export var HEALTH = 3 + GlobalVariables.health

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
var speed: int # How fast the player will move (pixels/sec).


func _ready():
	_state_machine.init(self)
	_score_ui = _base_ui.get_score_ui()
	_game_over_ui = _base_ui.get_game_over_ui()
	_health_ui = _base_ui.get_health_ui()
	health = HEALTH
	_health_ui._set_health(health)
	#_set_weapon()
	
func _unhandled_input(event: InputEvent):
	_state_machine.process_input(event)

func _process(delta: float):
	_state_machine.process_frame(delta)
	
func _physics_process(delta):
	_state_machine.process_physics(delta)
	

func _on_area_disabled_timer_timeout():#turn on and off the area2d to check for enemies so that they will follow the player as the player moves
	_enemy_follow_collision_shape.disabled = !_enemy_follow_collision_shape.disabled
	_area_for_enemy_follow_timer.start()

func handle_hurt_box():
	#play animation for hit flash
	_AP_Hit_Flash.play("HitFlash")
	#then while that animation plays, the player will be invincible to enemy attacks
	_enemy_check_collision_shape.disabled = true
	await get_tree().create_timer(_AP_Hit_Flash.current_animation_length).timeout
	_enemy_check_collision_shape.disabled = false

func get_weapon_manager():
	return get_node("WeaponManager")


func _on_enemy_check_area_2d_area_entered(area):
	print(area.get_groups())
	if area.is_in_group("EnemyHurtbox"):
		#push the player back in the direction the enemy was moving
		handle_hurt_box()
		var knockback_direction = area.global_position.direction_to(self.global_position) #get the direction from the enemy touched by to the player
		self.global_position += knockback_direction * 40 #move the player back in that direction by a strength
		if _allow_hit_timer.time_left <=0:
			print("hit timer")
			#set health
			health = health - 1
			_health_ui._set_health(health)
		_allow_hit_timer.start()
	# Must be deferred as we can't change physics properties on a physics callback.
	_enemy_check_collision_shape.set_deferred("disabled", true) #basically turn off the collision shape so we dont get more then one input at the end of the frame

func _on_enemy_check_area_2d_area_exited(area):
	_enemy_check_collision_shape.set_deferred("disabled", false)


func _on_area_for_enemy_follow_area_entered(area):
	if area.is_in_group("EnemyHitbox"):
		area.set_target_position(self.global_position)
		#print("area entered")
func _on_area_for_enemy_follow_area_exited(area):
	if area.is_in_group("EnemyHitbox"):
		await get_tree().create_timer(1.0).timeout #seconds
		if area != null:
			area.set_target_position_to_gather_point()

func set_speed(player_speed: int):
	speed = player_speed
