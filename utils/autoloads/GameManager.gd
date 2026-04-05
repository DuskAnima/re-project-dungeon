extends Node

# --------- SETUP --------- 
## Array que almacena a todos los actores. Las interacciones con los actores deberían ser mediadas desde aquí
var actors : Array[Entity]
var current_actor : Entity

func entity_setup(_act: Entity) -> void:
	prints("GM - entity setup:", _act)
	actors.push_back(_act)
	GridManager.grid_setup(_act)
	TurnManager.turn_setup(_act)
	TimeManager.time_setup(_act)
	
func game_loop() -> void:
	print("game loop started")
	current_actor = TurnManager.turn_process()
	print("TurnProcess init, current actor asigned")
	await TimeManager.timeout
	print("TimeOut signal")
	TurnManager.turn_iterator()
	print("Turn_iterator")
	game_loop()
	

func _on_ready_setup() -> void:
	register_controller()
	game_loop()

# --------- PLAYER CONTROLLER SETTING --------- 
## Variable Controller que guarda el registro del nodo que conecta el control del usuario con una entidad.
var controller : Controller = Controller.new()

## El controller invoca esta función y pasa self.
func register_controller() -> void:
	for actor in actors:
		if actor.properties.is_controllable == false:
			register_ai_controller(actor)
			return
		if actor.has_node("Controller"):
			push_error(actor, "ya tiene un control")
			return
		actor.add_child(controller)


# --------- NPC CONTROLLER SETTING --------- 
var current_ai: Entity = null
var ai_controller : AiController = AiController.new()

func register_ai_controller(actor: Entity) -> void:
	if actor.has_node("AiController"):
		push_error(actor, "ya tiene un control")
		return
	actor.add_child(ai_controller)

func set_current_ai_actor(_act: Entity) -> void:
	current_ai = _act
	if ai_controller:
		ai_controller.set_actor(_act)
