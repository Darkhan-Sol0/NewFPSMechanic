extends Area3D
class_name HitBox_Component

@export var health_component : Health_Component


func damage(Damage : DamegeBox_Component):
	if health_component:
		health_component.damage(Damage)
