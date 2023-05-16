extends CharacterBody3D

@export var AI : AI_Enemy
@export var player : CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var hp : int = 100 

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		print('die')
		queue_free()

func see_func(delta):
	$Head.rotation.y += delta

func _physics_process(delta):
	
	see_func(delta)
	
	AI.pattern()
	
	if not is_on_floor():
		velocity.y -= gravity * delta


	move_and_slide()
