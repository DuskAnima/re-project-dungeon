extends Node

func _ready() -> void:
	pass #GridManager.entity_moved.connect(grid_catcher)

func on_command_start(_time: Variant) -> void:
	if _time:
		TimeManager.set_command_time_cost(_time)


"func on_command_finished() -> void:
	TimeManager.timer_iterator_enabler()
"
