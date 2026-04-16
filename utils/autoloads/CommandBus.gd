extends Node

func _ready() -> void:
	pass #GridManager.entity_moved.connect(grid_catcher)

## Función que toma el Command recién ejecutado
func command_catcher(_cmd: Command) -> void:
	send_time_cost(_cmd.time_cost)
	if is_instance_of(_cmd, CommandSpawn):
		_set_object_initiative(_cmd)


func send_time_cost(time_cost : float) -> void:
	TimeManager.consume_time(time_cost)

func _set_object_initiative(_cmd : CommandSpawn) -> void:
	var fix_float : float = 0.00000000000001 
	var object_owner : Entity = _cmd.owner
	var object_initiative : float = TurnManager.get_entity_initiative(object_owner) - fix_float
	TurnManager.set_entity_initiative(_cmd.act, object_initiative)
