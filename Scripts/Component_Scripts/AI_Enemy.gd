extends Node
class_name AI_Enemy

@onready var attack_component = $"../Attack_Component"
@onready var Look = $"../Head"
@onready var t = $"../Head/look"

enum AI_Patter { IDLE, See_Player}
var ai_patter : AI_Patter

func change_pattern(new_pattern : AI_Patter):
	ai_patter = new_pattern

func pattern():
	look_at_player()
	match ai_patter:
		AI_Patter.IDLE:
			print('where are you')
		AI_Patter.See_Player:
			attack_component.shot()
			print('i see you')

func look_at_player():
	
	if owner.global_position.distance_to(owner.player.global_position) <= 10  and t.get_collider() == owner.player:
		Look.look_at(owner.player.global_position + Vector3(0,1,0))
		change_pattern(AI_Patter.See_Player)
	else:
		change_pattern(AI_Patter.IDLE)

