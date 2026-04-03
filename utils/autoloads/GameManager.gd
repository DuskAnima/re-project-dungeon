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
	print(actors, "le toca a ")

func _game_set_up() -> void:
	register_controller()

# --------- PLAYER CONTROLLER SETTING --------- 
## Variable Entity que guarda registro de la entidad controlada. 
var player : Entity
## Variable Controller que guarda el registro del nodo que conecta el control del usuario con una entidad.
var controller: Controller = Controller.new()

## El controller invoca esta función y pasa self.
func register_controller() -> void:
	for actor in actors:
		if actor.properties.is_controllable == false:
			return
		if actor.has_node("Controller"):
			push_error(actor, "ya tiene un control")
			return
		actor.add_child(controller)


# --------- NPC CONTROLLER SETTING --------- 
var current_ai: Entity = null
var ai_controller: AiController = null

func register_ai_controller(ctrl: AiController) -> void:
	ai_controller = ctrl
	if current_ai:
		ai_controller.set_actor(current_ai)

func set_current_ai_actor(_act: Entity) -> void:
	current_ai = _act
	if ai_controller:
		ai_controller.set_actor(_act)
