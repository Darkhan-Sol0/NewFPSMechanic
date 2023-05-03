extends RayCast3D
class_name Interactive_Look

func _init():
	collide_with_areas = true

func _ready():
	target_position = Vector3(0, 0, -3)
	add_exception(owner)

func Interactive():
	if is_colliding():
		if get_collider().owner.has_method("interactive"):
			get_collider().owner.interactive()
