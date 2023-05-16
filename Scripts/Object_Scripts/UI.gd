extends Control

@export var attack_component : Attack_Component

@onready var ammo_view = $Ammo

func _process(delta):
	ammo_view.text = str(attack_component.ammo)
