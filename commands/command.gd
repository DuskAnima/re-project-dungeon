@abstract
extends RefCounted
class_name Command

signal started
signal finished

var time_cost : float = _set_time_cost()
var is_executing : bool = false

@abstract
## Función de inicialización de comandos. Cada comando tiene diferentes requerimientos que deben ser implementados
## y documentados individualmente.
func _init() -> void

## La ejecución debe ser implementada. Siempre debe llamarse start() al comienzo de la implementación y finish() al
## final
@abstract
func execute() -> void

## Es necesario declarar el coste de tiempo con un return de un float
@abstract
func _set_time_cost() -> float

## Conecta a CommandBus
func start() -> void:
	started.connect(CommandBus.command_catcher, CONNECT_ONE_SHOT)
	is_executing = true
	started.emit(time_cost)

## Envía información pertinente a ActionQueue
func finish() -> void:
	is_executing = false
	finished.emit()
	
