extends Node

# --------- GLOBAL REFERENCES --------- 
## Referencia al nodo raíz del juego.
@onready var root : Node = get_tree().current_scene
## Variable de referencia al nodo Entities, el cual almacena todas las entidades. Es setteada desde el World node.
var entities_node : Node 
## Variable de referencua al nodo Auxiliar, el cual sirve para instanciar elementos no-Entity. Es setteada desde el World node.
var aux_node : Node
## Variable de referencia del estado de la state machine del juego.
var game_status : int = BOOT
## estados finitos del juego
enum {BOOT, SET, TURN_START, TURN_ACTIVE, TURN_END, GAME_OVER}
## Referencia a escena TurnPanel
const TURN_PANEL_SCENE : PackedScene = preload("uid://cglpe83i12wfp")
## Referencia a instancia de TurnPanel
var turn_panel : TurnPanel
# --------- SETUP --------- 
## Variable que revela al actor que está de turno
var current_actor : Entity

func entity_setup(_act: Entity) -> void:
	prints("GM - entity setup:", _act)
	TurnSystem.register_actor(_act)
	GridManager.register_actor(_act)

func game_fsm() -> void: #REFACTORIZAR EL GAME LOOP CON ESTO, WORK IN PROGRESS
	while game_status != GAME_OVER:
		match game_status:
			BOOT:
				_on_ready_setup() # Recibe el llamado de World y hace el primer setup de entidades.
				turn_panel = TURN_PANEL_SCENE.instantiate()
				root.get_node("UI").add_child(turn_panel)
				turn_panel.update_list()
				game_status = SET
				print("Boot ready")
			SET:
				current_actor = TurnSystem.get_next_actor() # Asigna al actor que le corresponda el turno
				print("Setting turn: ", current_actor)
				if current_actor == null: # Si no hay actores
					game_status = GAME_OVER # GameOver
				else:
					game_status = TURN_START
			TURN_START:
				current_actor.set_can_act(true)
				game_status = TURN_ACTIVE
			TURN_ACTIVE:
				await TurnSystem.time_depleted
				current_actor.set_can_act(false)
				await ActionQueue.all_commands_finished
				game_status = TURN_END
			TURN_END:
				TurnSystem.advance_turn()
				game_status = SET
			GAME_OVER:
				game_status += 1
	
func _on_ready_setup() -> void:
	for entity in entities_node.get_children():
		entity_setup(entity)
		register_controller(entity)

func kill_entity(_act: Entity) -> void:
	GridManager._update_grid(_act, _act.properties.grid_pos, GridManager.ENTITY_DELETE_FLAG)
	TurnSystem.unregister_actor(_act)
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
