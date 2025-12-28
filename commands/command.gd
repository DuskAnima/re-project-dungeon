@abstract
extends  RefCounted
class_name Command

signal finished

var actor : Entity
var is_executing : bool = false

func _init(_actor : Entity) -> void:
	actor = _actor
	
func execute() -> void:
	finish()

func setup(_actor) -> void:
	actor = _actor

func finish() -> void:
	is_executing = false
	finished.emit()
