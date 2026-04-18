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
		prints("Game loop started: iteration number ", counter, ".", current_actor, "turn")
		if current_actor == null:
			continue
		await TimeManager.timeout
		TimeManager.timer_reset(current_actor)
		TurnManager.turn_iterator()
	game_running = false

func _on_ready_setup() -> void:
	for entity in entities_node.get_children():
		entity_setup(entity)
		register_controller(entity)
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
## Función que agrega una instancia de control a la entidad entregada como argumento. 
func register_controller(_act : Entity) -> void:
	var entity_kind : String = _act.properties.entity_kind
	match entity_kind:
		"Player":
			_register_controller(_act, PlayerController)
		"Ai":
			_register_controller(_act, AiController)
		"Object":
			_register_controller(_act, ObjectController)

# --------- CONTROLLERS --------- 

## Función privada que gestiona la instanciación de Controllers a las respectivas Entities.
func _register_controller(_act: Entity, _controller_class: Variant) -> void:
	var node_name : String = _controller_class.get_global_name()
	var entity_kind : String = _act.properties.entity_kind
	if not node_name.contains(_act.properties.entity_kind):
		return
	if _act.has_node(node_name):
		push_error(_act, " ya posee un control tipo ", node_name)
		return
	var new_controller : Controller = _controller_class.new() 
	_act.add_child(new_controller)


	
	
