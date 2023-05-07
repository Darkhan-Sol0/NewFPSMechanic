extends StaticBody3D
class_name Interractive_Component

@export var interactive_object : Node3D

func _init():
	collision_layer = 4
	collision_mask = 0

func Interactive():
	if interactive_object:
		interactive_object.Interactive()
	else:
		print('ne hui!')

func Hover():
	pass
