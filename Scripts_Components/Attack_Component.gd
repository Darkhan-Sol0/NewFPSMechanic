extends Node
class_name Attack_Component

@export var weapon_component : Weapon_Component
@export var startbull : Marker3D

enum Fire_status { can_fire, reload }
var fire_status : Fire_status

var fired : bool = true
var reloaded : bool = false

var damage : int
var bullet : int

var Bullet = preload("res://Player/bullet.tscn")

func change_status( new_status : Fire_status):
	fire_status = new_status

func _ready():
	pass

func AttakeType(delta):
		match fire_status:
			Fire_status.can_fire:
				if weapon_component.bullet > 0 and fired:
					weapon_component.bullet -= 1
					for i in weapon_component.bullet_drop:
						shot(delta)
					fired = false
					await get_tree().create_timer(weapon_component.speed_shot).timeout
					fired = true
				elif weapon_component.bullet <= 0:
					reloaded = true
					change_status(Fire_status.reload)
			Fire_status.reload:
				if reloaded:
					reload()

func shot(delta): 
	var bullet_ins = Bullet.instantiate()
	var randomx = randf_range( -weapon_component.razbros, weapon_component.razbros)
	var randomy = randf_range( -weapon_component.razbros, weapon_component.razbros)
	bullet_ins.bullet_component.weapon_component = weapon_component
	bullet_ins.global_transform = startbull.global_transform
	bullet_ins.velocity = bullet_ins.transform.basis * Vector3(randomx, randomy, -weapon_component.large_fly * delta)
	GlobalScript.add_child(bullet_ins)

func reload():
	reloaded = false
	await get_tree().create_timer(1).timeout
	weapon_component.bullet = weapon_component.MAX_BULLET
	fired = true
	change_status(Fire_status.can_fire)

func attack(delta):
	match weapon_component.TypeShot:
		weapon_component.TYPE_SHOT.AUTOSHOT:
			if Input.is_action_pressed("LBM"):
				AttakeType(delta)
		weapon_component.TYPE_SHOT.SINGLESHOT:
			if Input.is_action_just_pressed("LBM"):
				AttakeType(delta)
