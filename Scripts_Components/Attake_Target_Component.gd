extends RayCast3D
class_name Attake_Target_Component

@onready var Damage_Box = $Damage_Box
@onready var Damage_col = $Damage_Box/CollisionShape3D
@onready var Damage_cell = $Damage_Box/MeshInstance3D

var large : int
var damage : int
var shoot_time : float
var shooting : bool

func _ready():
	add_exception(owner)
	Damage_col.disabled = true
	Damage_cell.visible = false
	
	shooting = true
	

func Attaked():
	damage = owner.Attake.damage
	large = owner.Attake.large
	shoot_time = owner.Attake.shoot_time
	
	if shooting:
		$AnimationPlayer.play("hit")
		shooting = false
		await get_tree().create_timer(shoot_time).timeout
		shooting = true


func _process(delta):
	target_position = Vector3(0, 0, -large)
	if is_colliding():
		Damage_Box.global_position = get_collision_point()
	else:
		Damage_Box.position = target_position
