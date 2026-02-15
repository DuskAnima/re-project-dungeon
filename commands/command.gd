@abstract
extends RefCounted
class_name Command

signal finished

#var actor : Entity
#var _source : Variant
#var _target : Variant
var time_cost : float = _set_time_cost()

var is_executing : bool = false

## Función de inicialización que requiere Entity, Orgen y Objetivo.
@abstract
func _init(_act : Entity,  _src : Variant, _targ : Variant) -> void

## La ejecución debe ser implementada.
@abstract
func execute() -> void

## Es necesario declarar el coste de tiempo con la variable "time_cost : float"
@abstract
func _set_time_cost() -> float

func send_cost() -> void:
	return TimeManager.set_command_time_cost(time_cost)

func finish() -> void:
	is_executing = false
	finished.emit()
