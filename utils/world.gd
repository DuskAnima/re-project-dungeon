extends Node2D


func _ready() -> void:
	GameManager.entities_node = %Entities
	GameManager.aux_node = %Auxiliar
	GameManager.game_fsm()
