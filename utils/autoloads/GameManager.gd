extends Node

# --------- SIGNALS ---------
signal turn_ended

# --------- GLOBAL REFERENCES --------- 
@onready var root : Node = get_tree().current_scene
## Variable de referencia al nodo Entities, el cual almacena todas las entidades. Es setteada desde el World node.
var entities_node : Node 
## Variable de referencua al nodo Auxiliar, el cual sirve para instanciar elementos no-Entity. Es setteada desde el World node.
var aux_node : Node
## Variable de referencia del estado de la state machine del juego.
var game_status : int = BOOT
## estados finitos del juego
enum {BOOT, SET, TURN_START, TURN_ACTIVE, TURN_END, GAME_OVER} # DIBUJAR UN ESQUEMA QUE ME AYUDE A RESOLVER ESTA ESTRUCTURA CON MIS DIFERENTES SERVICIOS
# --------- SETUP --------- 
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

func game_fsm() -> void: #REFACTORIZAR EL GAME LOOP CON ESTO, WORK IN PROGRESS
	match game_status:
		BOOT:
			_on_ready_setup() # Recibe el llamado de World y hace el primer setup de entidades.
			game_status = SET
		SET:
			current_actor = TurnManager.set_entity_turn()
			if current_actor == null:
				game_status = GAME_OVER
			TimeManager.timer_reset(current_actor)
			game_status = TURN_START
		TURN_START:
			current_actor.set_can_act(true)
			game_status = TURN_ACTIVE
		TURN_ACTIVE:
			game_status += 1
		TURN_END:
			game_status += 1
		GAME_OVER:
			game_status += 1


func _game_loop() -> void:  # Crear una maquina de estados para poder establecer las diferentes fases de resolución y evitar bugs
		current_actor = TurnManager.set_entity_turn()

		prints(current_actor, "turn")
		await ActionQueue.queue_empty
		await TimeManager.timeout

		prints(current_actor, "timeout")
		TimeManager.timer_reset(current_actor)
		TurnManager.turn_iterator()
		game_running = false

func _on_ready_setup() -> void:
	for entity in entities_node.get_children():
		entity_setup(entity)
		register_controller(entity)

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
	TurnManager.remove_entity_from_pool(_act)
	GridManager._update_grid(_act, _act.properties.grid_pos, GridManager.ENTITY_DELETE_FLAG)
	if current_actor == _act:
		current_actor = null
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
