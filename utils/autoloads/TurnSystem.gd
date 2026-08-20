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
var current_index : int = 0

## Flag para evitar múltiples timeout.
var _timeout_emitted : bool = false

# ----------------------------------------- #
# Métodos públicos
# ----------------------------------------- #

## Configurar un actor en el sistema de turnos. 
## La iniciativa debe ser asignada en el inspector. 
func register_actor(_act: Entity, initiative: float = NAN) -> void:
	if _act == null:
		push_error("TurnSystem: se intentó registrar un actor nulo")
		return
	if is_nan(initiative):
		initiative = _act.stats.initiative * randf_range(0.5, 1.5)
	turn_order.append([_act, initiative])
	_sort_turn_order()
	
## Registra un actor creado por otro actor asignándole una iniciativa justo por debajo de la del owner (origen del spawn).
## Esto garantiza que el turno del objeto será justo después del owner.
func register_spawned_actor(_act : Entity) -> void:
	const EPSILON : float = 0.00000000000001 # Valor extremadamente pequeño pero mayor a 0 
	var entity_owner : Entity = _act.get_entity_owner() # Obtiene al dueño de la entidad

	if entity_owner == null: # Si es nulo
		register_actor(_act) # Solo se registra sin owner
		return
	var owner_index : int = _find_entity_index(entity_owner)
	if owner_index == -1:
		register_actor(_act) # Solo se registra sin owner
		return
	var owner_initiative : float = turn_order[owner_index][INITIATIVE]
	register_actor(_act, owner_initiative - EPSILON)

## Recibe a un actor y lo elimina del sistema
func unregister_actor(_act: Entity) -> void:
	var index : int = _find_entity_index(_act)
	if index <= -1:
		push_error("TurnSystem: actor retorna índice negativo")
		return
	var was_current_actor : bool = (current_actor == _act)
	turn_order.remove_at(index) # Elimina al actor de la lista
	
	if turn_order.is_empty(): # Si la lista queda vacía
		current_actor = null
		current_index = 0
		return
		
	if was_current_actor: # Si se eliminó al actor actual
		current_actor = null
		current_index = current_index % turn_order.size()
		
	elif index < current_index: # Si estaba antes del actor actual retrocede 1 
		current_index -= 1
	# Si estaba después, no se toca el current index

## Asigna el turno al actor que sigue en la lista ordenada.
func get_next_actor() -> Entity:
	if turn_order.is_empty():
		current_actor = null
		return null
	if current_index < 0 or current_index >= turn_order.size():
		current_index = 0
	current_actor = turn_order[current_index][ACTOR]
	_reset_actor_time()
	_timeout_emitted = false
	return current_actor

## Consume tiempo del actor actual y empite time_depleted cuando llega a 0.0.
func spend_time(amount: float) -> void:
	if current_actor == null or _timeout_emitted:
		return
	var remaining : float = current_actor.get_time() - amount
	current_actor.set_time(max(remaining, 0.0))
	
	if current_actor.get_time() <= 0.0 and not _timeout_emitted:
		_timeout_emitted = true
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
		return 0.0
	return turn_order[index][INITIATIVE]

## Establece explícitamente la iniciativa de un actor y reordena la lista. Run-time intended.
func set_initiative(_act: Entity, new_initiative: float) -> void:
	var index : int = _find_entity_index(_act)
	if index <= -1:
		push_error("TurnSystem: set_initiative() retorna índice negativo")
		return
	turn_order[index][INITIATIVE] = new_initiative
	_sort_turn_order()

# ----------------------------------------- #
# Métodos privados
# ----------------------------------------- #

func _find_entity_index(_act: Entity) -> int:
	for i in range(turn_order.size()):
		if turn_order[i][ACTOR] == _act:
			return i
	return -1
	
func _reset_actor_time() -> void:
	if current_actor != null:
		current_actor.set_time(BASE_TIME)

func _sort_turn_order() -> void:
	turn_order.sort_custom(_sort_descending)
	if current_actor != null:
		current_index = _find_entity_index(current_actor)

func _sort_descending(a, b) -> bool:
	return a[1] > b[1]
