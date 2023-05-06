extends Node
class_name Health_Component

@export var MAX_HEALTH : int
var health_point : int

func _ready():
	health_point = MAX_HEALTH

func damage(damage : DamegeBox_Component):
	health_point -= damage.damage
	print(health_point)
	if health_point <= 0:
		get_parent().queue_free()

func healing(heal):
	if health_point < MAX_HEALTH:
		health_point += heal
	elif health_point > MAX_HEALTH:
		health_point = MAX_HEALTH
