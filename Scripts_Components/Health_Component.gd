extends Node
class_name Health_Component

@export var MAX_HEALTH : int
var health : int

func _ready():
	health = MAX_HEALTH

func damage(damage : DamegeBox_Component):
	health -= damage.damage
	print(health)
	if health <= 0:
		get_parent().queue_free()
