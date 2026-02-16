extends Node

func _ready() -> void:
	pass #GridManager.entity_moved.connect(grid_catcher)

func command_catcher(time: Variant) -> void:
	TimeManager.set_command_time_cost(time)
	
