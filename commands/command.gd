@abstract
extends RefCounted
class_name Command

signal finished

var actor : Entity
var _source : Variant
var _target : Variant
var time_cost : float

var is_executing : bool = false

func _init(act : Entity,  src : Variant, targ : Variant) -> void:
	actor = act
	_source = src
	_target = targ

## La ejecución debe ser implementada.
@abstract
func execute() -> void

@abstract
func _set_cost() -> void

func send_cost() -> void:
	return TimeManager.set_command_time_cost(time_cost)

func finish() -> void:
	is_executing = false
	finished.emit()
