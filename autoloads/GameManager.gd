extends Node

var current_actor: Entity = null
var controller: Controller = null

func register_controller(ctrl: Controller) -> void:
	controller = ctrl
	if current_actor:
		controller.set_actor(current_actor)

func set_current_actor(act: Entity) -> void:
	current_actor = act
	if controller:
		controller.set_actor(act)
