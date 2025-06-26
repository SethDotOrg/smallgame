extends Node2D

var sword = preload("res://Scenes/Weapons/Sword.tscn")
var axe = preload("res://Scenes/Weapons/Axe.tscn")

var weapon

func _ready():
	set_weapon()

func set_weapon():
	if GlobalVariables.weapon == "sword":
		weapon = sword.instantiate()
		add_child(weapon)
	elif GlobalVariables.weapon == "axe":
		weapon = axe.instantiate()
		add_child(weapon) 

func set_player_speed(player_speed: int):
	get_parent().set_speed(player_speed)

func apply_position_change_up(amount:float):
	get_parent().apply_position_change_up(amount)
func apply_position_change_down(amount:float):
	get_parent().apply_position_change_down(amount)
func apply_position_change_left(amount:float):
	get_parent().apply_position_change_left(amount)
func apply_position_change_right(amount:float):
	get_parent().apply_position_change_right(amount)
