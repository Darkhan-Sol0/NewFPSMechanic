extends Node3D

@export var damage_zone : DamegeBox_Component

var damage = 20

func Interactive():
	damage *= -1
	
	var colo = FogMaterial
	colo = Color(randf_range( 0, 1),randf_range( 0, 1),randf_range( 0, 1))
	
	$MeshInstance3D.get_active_material(0).albedo_color = colo
	
	$AnimationPlayer.play("flip")
