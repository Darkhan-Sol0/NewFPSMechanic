extends CharacterBody3D

@export var health_component : Health_Component
@export var attack_component : Attack_Component
@export var weapon_component : Weapon_Component
@export var intractive_connecting_player : Intractive_Connecting_Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func _input(event):
	if event is InputEventMouseMotion:
		var dx = -event.relative.x * 0.0025
		var dy = -event.relative.y * 0.0025
		rotate_y(dx)
		$Head.rotation.x = clamp($Head.rotation.x + dy, -PI/2, PI/2)

func gravity_func(delta) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

func movement() -> void:
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func get_input(delta):
	attack_component.attack(delta)
	
	intractive_connecting_player.Hover()
	
	if Input.is_action_just_pressed("Reload_button") and weapon_component.bullet < weapon_component.MAX_BULLET:
		attack_component.reload()
		
	if Input.is_action_just_pressed("Interactive"):
		intractive_connecting_player.Interactivy()

func _physics_process(delta):
	gravity_func(delta)
	movement()
	get_input(delta)

	move_and_slide()
