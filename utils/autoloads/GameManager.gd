extends Node

# --------- SETUP --------- 
func entity_setup(_act: Entity) -> void:
	GridManager.grid_setup(_act)
	TurnManager.turn_setup(_act)

# --------- PLAYER CONTROLLER SETTING --------- 
## Variable Entity que guarda registro de la entidad controlada. 
var current_actor: Entity = null
## Variable Controller que guarda el registro del nodo que conecta el control del usuario con una entidad.
var controller: Controller = null

## El controller invoca esta función y pasa self.
func register_controller(ctrl: Controller) -> void:
	controller = ctrl
	if current_actor:
		controller.set_actor(current_actor)

## Función que registra un nodo Entity como personaje controlable.
## Por defecto registra a Player.
func set_current_actor(_act: Entity) -> void:
	current_actor = _act
	if controller:
		controller.set_actor(_act)

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
