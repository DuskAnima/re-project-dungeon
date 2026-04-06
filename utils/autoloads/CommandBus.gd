extends Node

var cmd : Command

func _ready() -> void:
	pass #GridManager.entity_moved.connect(grid_catcher)

func command_catcher(_cmd: Command) -> void:
	cmd = _cmd
	send_time_cost(cmd.time_cost)

func send_time_cost(time_cost : float) -> void:
	TimeManager.consume_time(time_cost)
