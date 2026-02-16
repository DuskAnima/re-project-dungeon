@abstract
extends RefCounted
class_name Command

signal started
signal finished

var time_cost : float = _set_time_cost()
var is_executing : bool = false

@abstract
## Función de inicialización que requiere Entity, Orgen y Objetivo.
func _init(_act : Entity,  _src : Variant, _targ : Variant) -> void

@abstract
## La ejecución debe ser implementada.
func execute() -> void

@abstract
## Es necesario declarar el coste de tiempo con un return de un float"
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
	
