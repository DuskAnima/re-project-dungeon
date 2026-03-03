extends Command
class_name CommandMove

## Variable de inicialización para actor
var act : Entity
## Variable de inicialización para origen del movimiento Vector2i
var from : Vector2i
## Variable de inicialización de dirección Vector2i.DIR
var dir : Vector2i


## Command Move requiere recibir al actor de la acción, posición actual de grid y posición requerida de grid.
func _init(_act : Entity,  _from : Vector2i, _dir : Vector2i) -> void:
	act = _act
	from = _from
	dir = _dir

func execute() -> void:
	print(dir)
	# Grid new position
	var to : Vector2i = from + dir
	prints("act:", act, " from:", from, " to:", to)
	# Grid origin
	var global_from : Vector2 = GridManager._grid_to_world(from)
	# Grid destiny
	var global_to : Vector2 = GridManager._grid_to_world(to)
	prints("global from: ", global_from, " global_to:", global_to)
	if act == null:
		push_error("Command Move: Actor is Null")
		return

	if not GridManager.can_move(act, from, to):
		push_error("Command Move: Actor is not allowed to go this way")
		return

	start()

	GridManager.update_grid(act, to)
	GridManager.grid_movement(act, global_from, global_to)
	
	finish()

func _set_time_cost() -> float:
	return 0
