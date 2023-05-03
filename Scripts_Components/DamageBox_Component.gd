extends Area3D
class_name Damage_Box

var damage : int

func _init():
	collision_layer = 2
	collision_mask = 0

func _process(delta):
	damage = owner.damage
