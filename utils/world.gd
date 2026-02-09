extends Node2D

signal finished_set_up



func _ready() -> void:
	finished_set_up.connect(GameManager._game_set_up)
	finished_set_up.emit()
