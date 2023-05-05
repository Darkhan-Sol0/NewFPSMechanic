extends Node
class_name Weapon_Component

@export var damage : int
@export var MAX_BULLET : int
@export var speed_shot : float

enum TYPE_SHOT { AUTOSHOT, SINGLESHOT }

@export var TypeShot : TYPE_SHOT