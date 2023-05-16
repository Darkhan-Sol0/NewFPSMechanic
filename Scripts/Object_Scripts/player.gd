extends CharacterBody3D

@export var attack_component : Attack_Component

@export var speed : int = 5.0
@export var jump : int = 4.5


func _input(event):
	if event is InputEventMouseMotion:
		var dx = -event.relative.x * 0.0025
		var dy = -event.relative.y * 0.0025
		rotate_y(dx)
		$Head.rotation.x = clamp($Head.rotation.x + dy, -PI/2, PI/2)

func get_gravity(delta):
	var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	if not is_on_floor():
		velocity.y -= gravity * delta

func get_movement():
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

func get_input():
	attack_component.fire()
	
	if Input.is_action_just_pressed("reload"):
		attack_component.reload()

func _physics_process(delta):
	get_gravity(delta)
	get_movement()
	get_input()

	move_and_slide()
