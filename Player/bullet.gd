extends RigidBody3D
class_name bullet_class

@export var bullet_component : Bullet_Component

func _physics_process(delta):
	
	if get_colliding_bodies():
		queue_free()
	
	await get_tree().create_timer(2).timeout
	queue_free()


