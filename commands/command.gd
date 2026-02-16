@abstract
extends RefCounted
class_name Command

signal finished
signal started

#var actor : Entity
#var _source : Variant
#var _target : Variant
var time_cost : float = _set_time_cost()

var is_executing : bool = false

@abstract
## Función de inicialización que requiere Entity, Orgen y Objetivo.
func _init(_act : Entity,  _src : Variant, _targ : Variant) -> void

@abstract
## La ejecución debe ser implementada.
func execute() -> void

@abstract
## Es necesario declarar el coste de tiempo con la variable "time_cost : float"
func _set_time_cost() -> float

func send_cost() -> void:
	return TimeManager.set_command_time_cost(time_cost)

func finish() -> void:
	is_executing = false
	finished.emit()

func start() -> void:
	started.connect(CommandBus.command_catcher, CONNECT_ONE_SHOT)
	is_executing = true
	started.emit(time_cost)
	
