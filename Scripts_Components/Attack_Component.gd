extends Node
class_name Attack_Component

@export var weapon_component : Weapon_Component
@export var startbull : Marker3D

enum Fire_status { can_fire, waid_fire, reload }
var fire_status : Fire_status

var damage : int
var bullet : int
var speed_shot : float

var TypeShot

var Bullet = preload("res://Player/bullet.tscn")

func change_status( new_status : Fire_status):
	fire_status = new_status

func _ready():
	if weapon_component:
		damage = weapon_component.damage
		bullet = weapon_component.MAX_BULLET
		speed_shot = weapon_component.speed_shot
		TypeShot = weapon_component.TypeShot

func attack():
	match fire_status:
		Fire_status.can_fire:
			if bullet > 0:
				bullet -= 1
				shot()
				change_status(Fire_status.waid_fire)
				await get_tree().create_timer(speed_shot).timeout
				change_status(Fire_status.can_fire)
			elif bullet <= 0:
				change_status(Fire_status.reload)
		Fire_status.waid_fire:
			pass
		Fire_status.reload:
			reload()
			change_status(Fire_status.can_fire)

func shot(): 
	var bullet = Bullet.instantiate()
	bullet.global_transform = startbull.global_transform
	bullet.velocity = bullet.transform.basis.z * -1
	GlobalScript.add_child(bullet)

func reload():
	bullet = weapon_component.MAX_BULLET
