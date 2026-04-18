extends Node

# --------- GLOBAL REFERENCES --------- 
## Variable de referencia al nodo Entities, el cual almacena todas las entidades.
var entities_node : Node 

# --------- SETUP --------- 
## Boolean que termina el estado del juego
var game_running : bool = false
## Array que almacena a todos los actores. Las interacciones con los actores deberían ser mediadas desde aquí
var actors : Array[Entity]
## Variable que revela al actor que está de turno
var current_actor : Entity

func entity_setup(_act: Entity) -> void:
	prints("GM - entity setup:", _act)
	TurnManager.turn_setup(_act)
	GridManager.grid_setup(_act)
	TimeManager.time_setup(_act)
	actors.push_back(_act)
	
func _game_loop() -> void:
	game_running = true
	var counter : int = 0
	while game_running:
		counter += 1
		current_actor = TurnManager.turn_process()
		prints("game loop started: iteration number ", counter, ".", current_actor, "turn")
		if current_actor == null:
			continue
		await TimeManager.timeout
		TimeManager.timer_reset(current_actor)
		TurnManager.turn_iterator()
	game_running = false

func _on_ready_setup() -> void:
	for entity in entities_node.get_children():
		entity_setup(entity)
	register_controller()
	_game_loop()

func kill_entity(_act: Entity) -> void:
	var index_to_remove : int = -1
	for i in range(actors.size()): # Busca el índice de la entidad que se busca eliminar
		if actors[i] == _act:
			index_to_remove = i
			break
	if index_to_remove == -1: # SI la entidad no está en la lista, termina función.
		return
	actors.remove_at(index_to_remove)
	# Ajuste al índice actual de ser necesario
	if current_actor == _act:
		current_actor = null
	TurnManager.remove_entity_from_pool(_act)
	GridManager.update_grid(_act, _act.properties.grid_pos, GridManager.ENTITY_DELETE_FLAG)
	_act.queue_free()

# --------- CONTROLLER SETTING --------- 
## Variable Controller que guarda el registro del nodo que conecta el control del usuario con una entidad.
var controller : Controller

## Se agrega una instancia de control en las entidades
func register_controller() -> void:
	for actor in actors: # Itera por todas las Entity
		if actor.properties.entity_kind == "ai": # si no es controlable
			register_ai_controller(actor)
			continue
		elif actor.properties.entity_kind == "object":
			register_object_controller(actor)
			continue
		elif actor.properties.entity_kind == "player":
			register_player_controller(actor)
			continue

# --------- NPC CONTROLLER SETTING --------- 

func register_player_controller(actor: Entity) -> void:
	if actor.has_node("PlayerController"):
		push_error(actor, "ya tiene un control")
		return
	controller = PlayerController.new() # Crea un nuevo AiController
	actor.add_child(controller) # Y lo asigna como hijo de la entidad

func register_ai_controller(actor: Entity) -> void:
	if actor.has_node("AiController"):
		push_error(actor, "ya tiene un control")
		return
	controller = AiController.new() # Crea un nuevo AiController
	actor.add_child(controller) # Y lo asigna como hijo de la entidad
	
func register_object_controller(actor : Entity) -> void:
	if actor.has_node("ObjectController"):
		push_error(actor, "ya tiene un control")
		return
	controller = ObjectController.new() # Crea un nuevo AiController
	actor.add_child(controller) # Y lo asigna como hijo de la entidad
