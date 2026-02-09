extends Command
class_name CommandMove

## Variable de inicialización para actor
var act : Entity
## Variable de inicialización para origen del movimiento
var from : Vector2i
## Variable de inicialización para destino del movimiento
var to : Vector2i
## Tween que determina el trayecto del movimiento en grid
var tween : Tween
## Velocidad de desplazamiento entre tiles
var tween_speed : float = 0.2

## Command Move requiere recibir al actor de la acción, posición actual de grid y posición requerida de grid.
func _init(_act : Entity,  _src : Variant, _targ : Variant) -> void:
	act = _act
	from = _src
	to = _targ

func execute() -> void:
	var global_from : Vector2 = GridManager._grid_to_world(from)
	var global_to : Vector2 = GridManager._grid_to_world(to)

	if act == null:
		push_error("Command Move: Actor is Null")
		finish()
		return

	if not GridManager.can_move(act, from, to):
		finish()
		return

	is_executing = true

	GridManager.update_grid(act, to)
	send_cost()
	_tween_movement(act, global_from, global_to)
	finish()

func _set_time_cost() -> float:
	return 1

func _tween_movement(_act: Entity, _from : Vector2, _to : Vector2) -> void:
	tween = _act.create_tween()
	tween.tween_property(_act, "position", _to, tween_speed)
