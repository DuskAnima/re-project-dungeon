extends Node

func _ready() -> void:
	ActionQueue.command_completed.connect(_on_command_completed)
	
func _on_command_completed(cmd: Command) -> void:
	_apply_time_cost(cmd)
	_handle_special_cases(cmd)

func _apply_time_cost(cmd: Command) -> void:
	if cmd.act != null and cmd.time_cost > 0.0:
		TurnSystem.spend_time(cmd.time_cost)

func _handle_special_cases(_cmd: Command) -> void:
	pass
