extends Node

var cmd : Command

func _ready() -> void:
	pass #GridManager.entity_moved.connect(grid_catcher)

func on_command_start(_cmd: Command) -> void:
	cmd = _cmd

func send_time_cost(_time_cost : float) -> void:
	pass
	#TimeManager.consume_time(_time_cost)
