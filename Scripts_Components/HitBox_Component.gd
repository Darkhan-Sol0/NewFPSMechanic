extends Area3D
class_name Hit_Box

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	area_entered.connect(self._on_area_entered)

func _on_area_entered(Damage : Damage_Box):
	if Damage == null:
		return
	if owner.has_method("damage_func"):
		owner.damage_func(Damage.damage)
		print(Damage.damage)
