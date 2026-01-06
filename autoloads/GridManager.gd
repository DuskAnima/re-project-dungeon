extends Node

signal entity_moved()

func can_move(_actor: Entity, _from: Vector2i, _target: Vector2i) -> bool:
	return true

func move_entity(actor: Entity, _from: Vector2i, to: Vector2i) -> void:
	actor.grid_pos = to
	actor.position = actor.grid_pos
	entity_moved.emit()
	
