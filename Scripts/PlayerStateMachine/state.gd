#base class for state
class_name State
extends Node

@onready var _base_ui = $"../../BaseUI"
@export var _animation_name: String

## Hold a reference to the parent so that it can be controlled by the state
var parent: Player

var speed

func enter() -> void:
	parent._player_sprite.play(_animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.velocity = Vector2.ZERO # The player's movement vector.
	#get the players direction
	if Input.is_action_pressed("move_right"):
		parent.velocity.x += 1
	if Input.is_action_pressed("move_left"):
		parent.velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		parent.velocity.y += 1
	if Input.is_action_pressed("move_up"):
		parent.velocity.y -= 1
	return null



func get_state_name() -> String:
	return self.get_name()
