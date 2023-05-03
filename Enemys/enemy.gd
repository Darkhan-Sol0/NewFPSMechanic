extends CharacterBody3D

@onready var Health = $Health_Component

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func damage_func(amount: int):
	Health.HP -= amount
#	print(Health.HP)

func _physics_process(delta):

	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()
