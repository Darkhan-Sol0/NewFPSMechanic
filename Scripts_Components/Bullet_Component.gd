extends Node
class_name Bullet_Component

@export var weapon_component : Weapon_Component

var damage : int

func _ready():
	if weapon_component:
		damage = weapon_component.damage
	else:
		damage = 10
