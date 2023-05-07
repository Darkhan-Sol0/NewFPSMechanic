extends Camera3D

@export var weapon_component : Weapon_Component
@onready var ammoLabel = $HUD/Label

func _process(delta):
	ammoLabel.text = str(weapon_component.bullet)
