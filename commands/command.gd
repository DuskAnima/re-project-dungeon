@abstract
extends RefCounted
class_name Command

signal finished

var actor : Entity
var _source : Variant
var _target : Variant

var is_executing : bool = false

func _init(act : Entity,  src : Variant, targ : Variant) -> void:
	actor = act
	_source = src
	_target = targ

## La ejecución debe ser implementada.
@abstract
func execute() -> void

func finish() -> void:
	is_executing = false
	finished.emit()
