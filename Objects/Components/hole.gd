extends MeshInstance3D

func _process(delta):
	await get_tree().create_timer(1).timeout
	get_tree().queue_delete(self)
	pass
