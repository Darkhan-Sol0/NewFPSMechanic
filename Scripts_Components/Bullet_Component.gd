extends Node
class_name Bullet_Component

var attack_component : Attack_Component

var damage

func _ready():
	damage = attack_component.damage
