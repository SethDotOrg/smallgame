extends CharacterBody2D

signal hit

@export var _weapon_animation_player: AnimationPlayer
@export var speed = 200 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

@onready var sword_up = $Weapon/SwordUp
@onready var sword_down = $Weapon/SwordDown
@onready var sword_left = $Weapon/SwordLeft
@onready var sword_right = $Weapon/SwordRight
@onready var _player_sprite = $AnimatedSprite2D
@onready var _enemy_check_collision_shape = $EnemyCheckArea2D/EnemyCollisionShape2D

@onready var _area_for_enemy_follow_timer = $AreaForEnemyFollow/AreaDisabledTimer
@onready var _enemy_follow_collision_shape = $AreaForEnemyFollow/EnemyFollowCollisionShape

@onready var _score_ui = $Ui/Score
@onready var _game_over_ui = $Ui/GameOver

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	#get the players direction
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	

	if Input.is_action_just_pressed("ui_right") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		_weapon_animation_player.play("sword_right_animation")
		await _weapon_animation_player.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("ui_left") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		_weapon_animation_player.play("sword_left_animation")
		await _weapon_animation_player.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("ui_down") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		_weapon_animation_player.play("sword_down_animation")
		await _weapon_animation_player.animation_finished
		GlobalVariables.player_attacking = false
	if Input.is_action_just_pressed("ui_up") and GlobalVariables.player_attacking == false:
		GlobalVariables.player_attacking = true
		_weapon_animation_player.play("sword_up_animation")
		await _weapon_animation_player.animation_finished
		GlobalVariables.player_attacking = false

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed #normalize the velocity so if we get velocity (x,y) = (1,1) 
													#it wont be faster then only and x or y being 1.
		_player_sprite.play()
	else:
		_player_sprite.stop()
		
	move_and_slide()


func _on_sword_up_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.queue_free()
		GlobalVariables.score += 1
		_score_ui.update_score()
		check_score_for_sword()

func _on_sword_down_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		print("!")
		body.queue_free()
		GlobalVariables.score += 1
		_score_ui.update_score()
		check_score_for_sword()

func _on_sword_left_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.queue_free()
		GlobalVariables.score += 1
		_score_ui.update_score()
		check_score_for_sword()

func _on_sword_right_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.queue_free()
		GlobalVariables.score += 1
		_score_ui.update_score()
		check_score_for_sword()


func _on_game_time_timeout():
	_game_over_ui.visible = true
	get_tree().paused = true

func check_score_for_sword():
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


#func _on_player_area_check_area_entered(area):
	#target_position = area.global_position
#func _on_player_area_check_area_exited(area):
	#target_position = get_spawner_princess().global_position


func _on_area_for_enemy_follow_body_entered(body):
	if body.is_in_group("Enemy"):
		body.set_target_position(self.global_position)
		print("body entered")
func _on_area_for_enemy_follow_body_exited(body):
	if body.is_in_group("Enemy"):
		await get_tree().create_timer(1.0).timeout
		if body != null:
			body.set_target_position_to_gather_point()

func _on_area_disabled_timer_timeout():
	_enemy_follow_collision_shape.disabled = !_enemy_follow_collision_shape.disabled
	_area_for_enemy_follow_timer.start()


func _on_enemy_check_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		print("!!!!!!!")
		#push the player back in the direction the enemy was moving
		var knockback_direction = body.global_position.direction_to(self.global_position) #get the direction from the enemy touched by to the player
		self.global_position += knockback_direction * 50 #move the player back in that direction by a strength
	# Must be deferred as we can't change physics properties on a physics callback.
	_enemy_check_collision_shape.set_deferred("disabled", true) #basically turn off the collision shape so we dont get more then one input at the end of the frame
func _on_enemy_check_area_2d_body_exited(body):
	_enemy_check_collision_shape.set_deferred("disabled", false)
