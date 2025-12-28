extends Node

var entity = Entity.new()
spawn_player(player)
player_controller.entity = entity

func spawn(player) -> void:
	
