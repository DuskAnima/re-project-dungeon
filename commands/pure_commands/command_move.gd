extends Command
class_name CommandMove

## Variable de inicialización para origen del movimiento Vector2i
var from : Vector2i #
# Variable de inicialización de dirección Vector2i.DIR
var dir : Vector2i

## Command Move requiere recibir al actor de la acción, posición actual de grid y posición requerida de grid.
func _init(_act: Entity, _from: Vector2i, _dir: Vector2i) -> void:
	act = _act
	from = _from
	dir = _dir

func execute() -> void:

	start()
	await GridManager.move_entity(act, from, from + dir) 
	finish()

func _set_time_cost() -> float:
	return 0
	
