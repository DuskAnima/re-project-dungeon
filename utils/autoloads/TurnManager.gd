extends Node

enum { ACTOR, INITIATIVE } # Referencia para evitar magic number en turn_order
var turn_order : Array[Array] = [] # Entity / float. Lista ordenada de mayor a menor.
var current_actor : Entity
var current_index : int = 0

## Configura el funcionamiento básico de los turnos agregando entidades a la lista y asignando un turno.
func turn_setup(_act: Entity) -> void:
	var randomizer : float = randf_range(0.5, 1.5) # Genera un float random entre 0.5 y 1.5
	if _act == null: 
		push_error("AVISO: TurnManager.turn_setup() está recibiendo null en vez de una instancia de Entity")
		return
	# Obtiene stat de iniciativa del actor y se multiplica por el randomizer para dar variación al orden
	var rng_speed : float = _act.stats.initiative * randomizer 
	turn_order.append([ _act, rng_speed ]) # Agrega al actor y su velocidad de iniciativa rng a la lista
	turn_order.sort_custom(_sort_descending) # Se ordena la lista en función a la velocidad de manera descendiente

func remove_entity_from_pool(_act: Entity) -> void:
	var index_to_remove : int = -1
	for i in range(turn_order.size()): # Busca el índice de la entidad que se busca eliminar
		if turn_order[i][ACTOR] == _act:
			index_to_remove = i
			break

	if index_to_remove == -1: # SI la entidad no está en la lista, termina función.
		return
	turn_order.remove_at(index_to_remove)
	# Ajuste al índice actual de ser necesario
	if index_to_remove < current_index:
		current_index -= 1 # Se retrocede uno al índice
	elif index_to_remove == current_index:
		if current_actor == _act:
			current_actor = null
		current_index -= 1
		if current_index < 0:
			current_index = 0
		

func _sort_descending(a, b) -> bool:
	return a[1] > b[1]

## ADVERTENCIA: Función con dependencia fuerte con ActionQueue. [br]
## Termina el turno de la entidad y da acceso a que la siguiente entidad pueda actuar.
func turn_iterator() -> void:
	if current_actor != null:
		current_actor.set_can_act(false) # Establece que ya no puede moverse
	current_index += 1 # Mueve el puntero un elemento extra
	if current_index == turn_order.size(): # Si se llega al final de la lista, esta comienza desde el principio
		current_index = 0


## Da acceso a que la unidad correspondiente pueda tomar su turno al establecer can_act = true. [br]
## Retorna la entidad de turno.
func turn_process() -> Entity:
	current_actor = turn_order[current_index][ACTOR] # Toma al actor de turno
	current_actor.set_can_act(true) # Establece que puede moverse
	return current_actor
