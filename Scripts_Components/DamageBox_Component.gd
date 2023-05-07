extends Area3D
class_name DamegeBox_Component

@export var bullet_component : Bullet_Component

var damage

func _ready():
	area_entered.connect(self._on_area_entered)

func _on_area_entered(hitbox : HitBox_Component):
	damage = bullet_component.damage
	
	if hitbox == null:
		return
	if hitbox.has_method("damage"):
		hitbox.damage(self)
