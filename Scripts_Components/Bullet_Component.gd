extends Node
class_name Bullet_Component

@export var attack_component : Attack_Component

var damage : int

func _ready():
	if attack_component:
		damage = attack_component.damage
	else:
		damage = 10
