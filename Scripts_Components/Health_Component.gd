extends Node
class_name Health_Component

@export var HP_max : int
var HP

func _ready():
	HP = HP_max

func die():
	if HP<= 0:
		owner.queue_free()
		print(owner.name, " is die!")

func _process(delta):
	die()
