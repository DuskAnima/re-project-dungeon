@abstract
extends RefCounted
class_name Command

signal finished

# Referencia general a la entidad que está instanciando el Command.
var act : Entity
# Referencia general a Strings de dirección en caso de necesitar ejecutar animaciones dependientes de la actual act.properties.face_position de la entidad
var DIR : Dictionary[Vector2i, String] = { Vector2i.UP : "UP", Vector2i.DOWN : "DOWN", Vector2i.LEFT : "LEFT", Vector2i.RIGHT : "RIGHT"}  
# Referencia al valor de tiempo de un Command. Debe ser establecida sobreescrimiendo _set_time_cost() y redefinida en ejecusión
var time_cost : float = _set_time_cost()
# Flag de ejecusión. Pasa a true tras start().
var is_executing : bool = false
# Identificador único para depuración.
var _debug_id: int = randi_range(0, 1000)
# Identificador del nombre de un Command para depuración.
var name : String = get_script().get_global_name()

## Función de inicialización de comandos. Cada comando tiene diferentes requerimientos que deben ser implementados
## y documentados individualmente.
@abstract
func _init(_act : Entity) -> void

@abstract
func execute() -> void
## La ejecución debe ser implementada. Siempre debe llamarse start() al comienzo de la implementación y finish() al
## final

@abstract
func _set_time_cost() -> float
## Es necesario declarar el coste de tiempo con un return de un float.


func start() -> void: ## Genera el flag de ejecusión.
	is_executing = true # Flag de ejecución

## Envía información pertinente a ActionQueue
func finish() -> void:
	is_executing = false
	finished.emit()

func _to_string() -> String:
	return "%s(id=%d)" % [get_script().get_global_name(), _debug_id]
