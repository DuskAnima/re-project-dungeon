extends Node2D

signal finished_set_up



func _ready() -> void:
	GameManager.entities_node = %Entities
	finished_set_up.connect(GameManager._on_ready_setup)
	finished_set_up.emit()
