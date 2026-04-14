extends Node

func _ready() -> void:
	pass #GridManager.entity_moved.connect(grid_catcher)

## Función que toma el Command recién ejecutado
func command_catcher(_cmd: Command) -> void:
	send_time_cost(_cmd.time_cost)


func send_time_cost(time_cost : float) -> void:
	TimeManager.consume_time(time_cost)
