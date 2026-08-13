extends Node

## Señal que se emite cuando el tiempo del actor llega a 0
signal time_depleted

enum { ACTOR, INITIATIVE } # Índices para el array interno [entity, initiative]

## Tiempo base que se asigna a cada actor.
const BASE_TIME : float = 2.0

## Lista de actores ordenada de mayor a menor basado en iniciativa.
## Cada elemento es un array de dos posiciones
var turn_order : Array[Array] = []

## Actor de turno
var current_actor : Entity = null

## Índice del turno actual dentro del turn_order
var current_index : int

## Flag para evitar múltiples timeout.
var _timeout_emited : bool = false

# ----------------------------------------- #
# Métodos públicos
# ----------------------------------------- #

## Configurar un actor en el sistema de turnos. 
## La iniciativa debe ser asignada en el inspector. 
func register_actor(_act: Entity, initiative: float = -1.0) -> void:
	if _act == null:
		push_error("TurnSystem: se intentó registrar a un actor nulo")
		return
	
	# Si no se pasa un valor explícito, se calcula con el valor asignado en el inspector.
	if initiative < 0.0: 
		var random_factor : float = randf_range(0.5, 1.5)
		initiative = _act.stats.initiative * random_factor
	turn_order.append([_act, initiative])
	turn_order.sort_custom(_sort_descending)
	
## Registra un actor creado por otro actor asignándole una iniciativa justo por debajo de la del owner (origen del spawn).
## Esto garantiza que el turno del objeto será justo después del owner.
func register_spawned_actor(_act : Entity) -> void:
	const EPSILON : float = 0.00000000000001 # Valor extremadamente pequeño pero mayor a 0 
	var entity_owner : Entity = _act.get_entity_owner()
	if entity_owner == null:
		_act.set_entity_owner(null)
		return
	var owner_initiative : float = get_initiative(entity_owner)
	register_actor(_act, owner_initiative - EPSILON)

## Recibe a un actor y lo elimina del sistema
func unregister_actor(_act: Entity) -> void:
	var index : int = _find_entity_index(_act)
	if index <= -1:
		push_error("TurnSystem: actor retorna índice negativo")
		return
	# Ajusta el índice actual de ser necesario.
	# Caso 1: el índice es menor al índice actual.
	if index < current_index: 
		current_index -= 1
	# Caso 2: el actor eliminado está en su turno.
	elif index == current_index and current_actor == _act: 
		current_actor = null
	turn_order.remove_at(index)
	if turn_order.is_empty():
		current_index = 0


## Asigna el turno al actor que sigue en la lista ordenada.
func get_next_actor() -> Entity:
	if turn_order.is_empty():
		current_actor = null
		return null
	if current_index < 0 or current_index >= turn_order.size():
		push_error("TurnSystem: current_index fuera del rango de turn_order.")
		return
	current_actor = turn_order[current_index][ACTOR]
	_reset_actor_time()
	_timeout_emited = false
	return current_actor

## Consume tiempo del actor actual y empite time_depleted cuando llega a 0.0.
func spend_time(amount: float) -> void:
	if current_actor == null or _timeout_emited:
		return
	var remaining : float = current_actor.properties.time - amount
	current_actor.properties.time = max(remaining, 0.0)
	
	if current_actor.properties.time <= 0.0 and not _timeout_emited:
		_timeout_emited = true
		time_depleted.emit()

## Avanza el índice de turno al siguiente actor sin asignarlo aun.
func advance_turn() -> void:
	if turn_order.is_empty():
		return
	current_index = (current_index + 1) % turn_order.size()

## Recibe un actor y retorna un float de su iniciativa.
func get_initiative(_act: Entity) -> float:
	var index : int = _find_entity_index(_act)
	if index == -1:
		push_error("TurnSystem: get_initiative() retorna índice negativo")
		return 0.0
	return turn_order[index][INITIATIVE]

## Establece explícitamente la iniciativa de un actor y reordena la lista. Run-time intended.
func set_initiative(_act: Entity, new_initiative: float) -> void:
	var index : int = _find_entity_index(_act)
	if index <= -1:
		push_error("TurnSystem: set_initiative() retorna índice negativo")
		return
	turn_order[index][INITIATIVE] = new_initiative
	turn_order.sort_custom(_sort_descending)

# ----------------------------------------- #
# Métodos privados
# ----------------------------------------- #

func _find_entity_index(_act: Entity) -> int:
	for i in range(turn_order.size()):
		if turn_order[i][ACTOR] == _act:
			return i
	push_error("TurnSystem: actor no encontrado en turn_order")
	return -1
	
func _reset_actor_time() -> void:
	if current_actor != null:
		current_actor.properties.time = BASE_TIME

func _sort_descending(a, b) -> bool:
	return a[1] > b[1]
