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
	
func _game_loop() -> void:
	print("game loop started")
	current_actor = TurnManager.turn_process()
	prints("TurnProcess init, current actor", current_actor, "can act? =", current_actor.properties.can_act)
	await TimeManager.timeout
	print("TimeOut signal")
	TimeManager.timer_reset(current_actor)
	TurnManager.turn_iterator()
	print("Turn_iterator")
	await ActionQueue.queue_empty
	_game_loop()
	

func _on_ready_setup() -> void:
	register_controller()
	_game_loop()

# --------- CONTROLLER SETTING --------- 
## Variable Controller que guarda el registro del nodo que conecta el control del usuario con una entidad.
var controller : Controller
var ai_controller : AiController 

## Se agrega una instancia de control en las entidades
func register_controller() -> void:
	for actor in actors: # Itera por todas las Entity
		if actor.properties.is_controllable == false: # si no es controlable
			register_ai_controller(actor)
			continue
		if actor.has_node("Controller"):
			push_error(actor, "ya tiene un control")
			continue
		controller = Controller.new() # Si no es un NPC, se crea un controller 
		actor.add_child(controller) # Y se asigna 

# --------- NPC CONTROLLER SETTING --------- 

func register_ai_controller(actor: Entity) -> void:
	if actor.has_node("AiController"):
		push_error(actor, "ya tiene un control")
	ai_controller = AiController.new() # Crea un nuevo AiController
	actor.add_child(ai_controller) # Y lo asigna como hijo de la entidad
