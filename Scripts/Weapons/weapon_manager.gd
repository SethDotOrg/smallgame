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
