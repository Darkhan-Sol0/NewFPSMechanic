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
var speed_shot : float

var TypeShot
var TypeBullet

var Bullet = preload("res://Player/bullet.tscn")

func change_status( new_status : Fire_status):
	fire_status = new_status

func _ready():
	if weapon_component:
		damage = weapon_component.damage
		bullet = weapon_component.MAX_BULLET
		speed_shot = weapon_component.speed_shot
		TypeShot = weapon_component.TypeShot
		TypeBullet = weapon_component.TypeBullet

func AttakeType(delta):
	if TypeBullet == weapon_component.TYPE_BULLET.SINGLE:
		match fire_status:
			Fire_status.can_fire:
				if bullet > 0 and fired:
					bullet -= 1
					shot(delta)
					fired = false
					await get_tree().create_timer(speed_shot).timeout
					fired = true
				elif bullet <= 0:
					reloaded = true
					change_status(Fire_status.reload)
			Fire_status.reload:
				if reloaded:
					reload()
	if TypeBullet == weapon_component.TYPE_BULLET.DROP:
		match fire_status:
			Fire_status.can_fire:
				if bullet > 0 and fired:
					bullet -= 1
					for i in 10:
						shot(delta)
					fired = false
					await get_tree().create_timer(speed_shot).timeout
					fired = true
				elif bullet <= 0:
					reloaded = true
					change_status(Fire_status.reload)
			Fire_status.reload:
				if reloaded:
					reload()

func shot(delta): 
	var bullet_ins = Bullet.instantiate()
	var randomx = randf_range( -weapon_component.razbros, weapon_component.razbros)
	var randomy = randf_range( -weapon_component.razbros, weapon_component.razbros)
	bullet_ins.bullet_component.attack_component = self
	bullet_ins.global_transform = startbull.global_transform
	bullet_ins.velocity = bullet_ins.transform.basis * Vector3(randomx, randomy, -weapon_component.large_fly * delta)
	GlobalScript.add_child(bullet_ins)

func reload():
	reloaded = false
	await get_tree().create_timer(1).timeout
	bullet = weapon_component.MAX_BULLET
	fired = true
	change_status(Fire_status.can_fire)

func attack(delta):
	if TypeShot == weapon_component.TYPE_SHOT.AUTOSHOT:
		if Input.is_action_pressed("LBM"):
			AttakeType(delta)
	if TypeShot == weapon_component.TYPE_SHOT.SINGLESHOT:
		if Input.is_action_just_pressed("LBM"):
			AttakeType(delta)
