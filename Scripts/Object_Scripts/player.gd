extends CharacterBody3D

@export var attack_component : Attack_Component

@export var speed : float = 6.0
@export var jump : float = 4.5

var speed_stop : float
var can_jump : bool = true


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
		speed_stop = 0.01
	else:
		can_jump = true
		speed_stop = speed

func get_movement():
	if Input.is_action_just_pressed("space") and can_jump:
		velocity.y = jump
		if not is_on_floor():
			can_jump = false

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed_stop)
		velocity.z = move_toward(velocity.z, 0, speed_stop)

func get_input():
	attack_component.fire()
	
	if Input.is_action_just_pressed("reload"):
		attack_component.reload()

func _physics_process(delta):
	get_gravity(delta)
	get_movement()
	get_input()

	move_and_slide()
