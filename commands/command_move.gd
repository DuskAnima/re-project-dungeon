extends Command
class_name CommandMove

## Variable de inicialización para origen del movimiento Vector2i
var from : Vector2i #
# Variable de inicialización de dirección Vector2i.DIR
var dir : Vector2i
# Variable que almacena el tween de movimiento
var tween : Tween

## Command Move requiere recibir al actor de la acción, posición actual de grid y posición requerida de grid.
func _init(_act: Entity, _from: Vector2i, _dir: Vector2i) -> void:
	act = _act
	from = _from
	dir = _dir

func execute() -> void:
	# Grid new position
	var to : Vector2i = from + dir



	start()


	# Grid origin
	var global_from : Vector2 = GridManager._grid_to_world(from)
	# Grid destiny
	var global_to : Vector2 = GridManager._grid_to_world(to)
	# Tween de movimiento. Actualiza la posición global de la unidad.
	tween = GridManager.grid_movement(act, global_from, global_to)
	await tween.finished
	# Actualiza los valores lógicos del grid y propaga las correspondientes reacciones de los tiles. 
	GridManager.update_grid(act, from, to) 
	finish()

func _set_time_cost() -> float:
	return 0
	
