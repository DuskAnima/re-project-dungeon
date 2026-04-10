@abstract
extends RefCounted
class_name Command

signal finished

var act : Entity
var time_cost : float = _set_time_cost()
var is_executing : bool = false
# Identificador único para depuración
var _debug_id: int = randi_range(0, 1000)
var name : String = get_script().get_global_name()

## Función de inicialización de comandos. Cada comando tiene diferentes requerimientos que deben ser implementados
## y documentados individualmente.
func _init(_act : Entity) -> void:
	act = _act

## La ejecución debe ser implementada. Siempre debe llamarse start() al comienzo de la implementación y finish() al
## final
@abstract
func execute() -> void

## Es necesario declarar el coste de tiempo con un return de un float
@abstract
func _set_time_cost() -> float

## Conecta a CommandBus y envía el comando para procesarse en el momento en el que comienza su ejecución
func start() -> void:
	is_executing = true # Flag de ejecución

## Envía información pertinente a ActionQueue
func finish() -> void:
	is_executing = false
	finished.emit()

func _to_string() -> String:
	return "%s(id=%d)" % [get_script().get_global_name(), _debug_id]
