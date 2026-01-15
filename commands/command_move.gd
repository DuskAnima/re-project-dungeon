extends Command
class_name CommandMove

## Variable source nombrada "from" por legibilidad.
var from : Vector2i:
	get:
		return _source
	set(value):
		_source = value
## Variable target nombrada "to" por legibilidad.
var to : Vector2i:
	get:
		return _target
	set(value):
		_target = value
## Tween que determina el trayecto del movimiento en grid
var tween : Tween
# Velocidad de desplazamiento entre tiles
var tween_speed : float = 0.2

## Command Move requiere recibir al actor de la acción, posición actual de grid y posición requerida de grid.
func _init(act: Entity, from_: Vector2i, to_: Vector2i) -> void:
	super(act, from_, to_)
	_set_cost()

func execute() -> void:
	var global_from : Vector2 = GridManager._grid_to_world(from)
	var global_to : Vector2 = GridManager._grid_to_world(to)

	if actor == null:
		push_error("Command Move: Actor is Null")
		finish()
		return

	if not GridManager.can_move(actor, from, to):
		finish()
		return

	is_executing = true

	GridManager.update_grid(actor, to)
	send_cost()
	_tween_movement(actor, global_from, global_to)
	finish()

func _set_cost() -> void:
	time_cost = 1

func _tween_movement(_act: Entity, _from : Vector2, _to : Vector2) -> void:
	tween = _act.create_tween()
	tween.tween_property(_act, "position", _to, tween_speed)
