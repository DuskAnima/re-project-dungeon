extends Command
class_name CommandMove

## Tiempo que tarda este comando en ejecutarse
@export var turn_time : float = 1
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

## Command Move requiere recibir al actor de la acción, posición actual de grid y posición requerida de grid.
func _init(act: Entity, from_: Vector2i, to_: Vector2i) -> void:
	super(act, from_, to_)

func execute() -> void:
	is_executing = true

	if actor == null:
		push_error("Command Move: Actor is Null")
		finish()
		return

	if not GridManager.can_move(actor, from, to):
		finish()
		return
	GridManager.move_entity(actor, from, to)
	finish()
