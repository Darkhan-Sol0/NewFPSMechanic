extends Node
class_name Weapon_Component

@export var damage : int
@export var MAX_BULLET : int
@export var speed_shot : float
@export var large_fly : float
@export var razbros : float

var bullet : int

@export var bullet_drop : int = 1

enum TYPE_SHOT { AUTOSHOT, SINGLESHOT }

@export var TypeShot : TYPE_SHOT

func _ready():
	bullet = MAX_BULLET
