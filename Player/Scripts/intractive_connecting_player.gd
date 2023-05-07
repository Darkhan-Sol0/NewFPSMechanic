extends Node3D
class_name Intractive_Connecting_Player

@onready var Target_look = $Target_Look

var target

func _ready():
	Target_look.target_position.z = -3
	Target_look.add_exception(owner)
	
	Target_look.collision_mask = 4

func Interactivy() -> void:
	Hover()
	if target:
		if target.has_method('Interactive'):
			target.Interactive()
	else:
		print('hui')
		return

func Hover():
	
	if Target_look.is_colliding():
		target = Target_look.get_collider()
	else:
		return
