extends Node

# ToDO:
# - Permitir que se consuma el action Queue
# - Denegar inputs fuera de tiempo

signal turn_started
signal turn_ended

var turn_order : Array[Array] = [] # Entity / float. Lista ordenada de mayor a menor.
var current_actor : Entity
var current_index : int = 1
var timer : float = 2

func _ready() -> void:
	turn_ended.connect(_on_turn_ended)
	turn_started.connect(_on_turn_started)

func execute_turn() -> void:
	if turn_order.is_empty(): return
	
	while timer >= 0:
		turn_started.emit()
		_set_current_actor()
		current_actor.set_can_act(true)
	
	turn_ended.emit()
	current_actor.set_can_act(false)
	next_turn()

func next_turn() -> void:
	timer = 2
	execute_turn()


## La notificación de que inició el turno ejecuta el timer y los queues
func _on_turn_started() -> void:
	pass

## Cuando el timer acaba, notifica que se acabó el turno y pasa al siguiente 
func _on_turn_ended() -> void:
	pass

func turn_setup(_act: Entity) -> void:
	var randomizer : float = randf_range(0.5, 1.5)
	if _act == null:
		return
	var rng_speed : float = _act.initiative * randomizer
	turn_order.append([ _act, rng_speed ])
	turn_order.sort_custom(_sort_descending)

func _set_current_actor() -> void:
	current_actor = turn_order[current_index - 1][0]
	print(current_actor)

func _sort_descending(a, b) -> bool:
	if a[1] > b[1]:
		return true
	return false

# Not working, need a huge refactor !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
