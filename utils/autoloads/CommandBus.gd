extends Node

var cmd : Command

func _ready() -> void:
	pass #GridManager.entity_moved.connect(grid_catcher)

func on_command_start(_cmd: Command) -> void:
	cmd = _cmd

func send_time_cost(time_cost : float) -> void:
	TimeManager.consume_time(time_cost)

"func on_command_finished() -> void:
	TimeManager.timer_iterator_enabler()
"
