extends RigidBody3D

var damage
var hole_ins = preload("res://Objects/Components/hole.tscn").instantiate()


func _ready():
	body_entered.connect(self._on_body_entered)

func _on_body_entered(cell : Node3D):
	if cell == null:
		return
	
	if cell == self:
		return
	
	if cell.has_method("take_damage"):
		cell.take_damage(damage)
	
	hole_ins.global_transform = global_transform
	Global.add_child(hole_ins)
	
	
	queue_free()
