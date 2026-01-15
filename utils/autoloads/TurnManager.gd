extends Node

# ToDO:
# - Permitir que se consuma el action Queue
# - Denegar inputs fuera de tiempo

var turn_order : Array[Array] = [] # Entity / float. Lista ordenada de mayor a menor.
var current_actor : Entity
var current_index : int = 0

func turn_setup(_act: Entity) -> void:
	var randomizer : float = randf_range(0.5, 1.5)
	if _act == null:
		return
	var rng_speed : float = _act.stats.initiative * randomizer
	turn_order.append([ _act, rng_speed ])
	turn_order.sort_custom(_sort_descending)

func _sort_descending(a, b) -> bool:
	if a[1] > b[1]:
		return true
	return false

func turn_iterator() -> void:
	var unit : Entity = turn_order[current_index][0] # Toma la entidad de turno
	unit.set_can_act(false) # Establece que ya no puede moverse
	current_index += 1 # Mueve el puntero un elemento extra
	if current_index == turn_order.size():
		current_index = 0
	turn_process()

func turn_process() -> void:
	var unit : Entity = turn_order[current_index][0] # Toma la unidad de turno
	if unit.is_controllable == false: # Si la unidad no es controlable
		GameManager.set_current_ai_actor(unit) # Se inyecta la Entity al AiController
	unit.set_can_act(true) # Establece que puede moverse

## Señal recibida de TimeManager avisando que el tiempo del turno se acabó
func _on_timeout() -> void:
	turn_iterator()

func _on_start() -> void:
	turn_process()
