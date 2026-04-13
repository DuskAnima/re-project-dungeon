extends Node

# --------- SETUP --------- 
## Boolean que termina el estado del juego
var game_running : bool = false

var current_command : Command
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
	var counter : int = 0
	while game_running:
		counter += 1
		prints("game loop started: iteration number ", counter)
		current_actor = TurnManager.turn_process()
		await TimeManager.timeout
		TimeManager.timer_reset(current_actor)
		TurnManager.turn_iterator()


func _on_ready_setup() -> void:
	register_controller()
	game_running = true
	_game_loop()

func kill_entity(_act: Entity) -> void:
	pass

# --------- CONTROLLER SETTING --------- 
## Variable Controller que guarda el registro del nodo que conecta el control del usuario con una entidad.
var controller : Controller

## Se agrega una instancia de control en las entidades
func register_controller() -> void:
	for actor in actors: # Itera por todas las Entity
		if actor.properties.entity_kind == "ai": # si no es controlable
			register_ai_controller(actor)
			continue
		if actor.properties.entity_kind == "object":
			register_object_controller(actor)
			continue
		if actor.has_node("PlayerController"):
			push_error(actor, "ya tiene un control")
			continue
		controller = PlayerController.new() # Si no es un NPC, se crea un controller 
		actor.add_child(controller) # Y se asigna 

# --------- NPC CONTROLLER SETTING --------- 

func register_ai_controller(actor: Entity) -> void:
	if actor.has_node("AiController"):
		push_error(actor, "ya tiene un control")
	controller = AiController.new() # Crea un nuevo AiController
	actor.add_child(controller) # Y lo asigna como hijo de la entidad

func register_object_controller(actor : Entity) -> void:
	if actor.has_node("ObjectController"):
		push_error(actor, "ya tiene un control")
	controller = ObjectController.new() # Crea un nuevo AiController
	actor.add_child(controller) # Y lo asigna como hijo de la entidad
