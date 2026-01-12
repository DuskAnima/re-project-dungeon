extends Node

# ToDO:
# - Permitir que se consuma el action Queue
# - Denegar inputs fuera de tiempo
# - Order guarda una referencia a las entidades en el orden correspondiente. Turn manager deberá inyectar
# la ia correspondiente al turno en GameManager.

signal turn_started
signal turn_ended

var order : Array[Entity] = []
var current_index : int
var current_actor : Entity


func turn_setup(_act: Entity) -> void:
	var randomizer : float = randf_range(0.5, 1.5)
	if _act == null:
		return
	order.append(_act)
	order.sort_custom(rng_turn)


func rng_turn(a: Entity, b: Entity) -> bool:
	return true
