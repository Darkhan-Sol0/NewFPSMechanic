extends Node

func _input(event):
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
