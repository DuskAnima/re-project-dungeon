extends Node


func _ready() -> void:
	TurnManager.call_deferred("turn_process")
