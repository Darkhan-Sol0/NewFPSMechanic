extends CharacterBody3D

@onready var look_interactive = $Head/Interactive_Look
@onready var Health = $Health_Component
@onready var Attake = $Attake_Component
@onready var Attake_target = $Head/Attake_Target_Component

@export var accele : float
@export var SPEED : int
@export var JUMP_VELOCITY : int

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func gravity_func(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

func _input(event):
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion:
		var dx = -event.relative.x * accele
		var dy = -event.relative.y * accele
		rotate_y(dx)
		$Head.rotation.x = clamp($Head.rotation.x + dy, -PI/2, PI/2)

func movement():
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("ctrl"):
		$Head.position.y = 1
		$CollisionShape3D.position.y = 0
		$CollisionShape3D.scale.y = 0.2
	else:
		$Head.position.y = 2
		$CollisionShape3D.position.y = 1
		$CollisionShape3D.scale.y = 1

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func get_input():
	if Input.is_action_just_pressed("Interactive"):
		look_interactive.Interactive()
	
	if Input.is_action_pressed("LBM"):
		Attake_target.Attaked()

func _physics_process(delta):
	gravity_func(delta)
	movement()
	get_input()
	
	move_and_slide()
