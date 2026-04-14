extends Controller
class_name ObjectController

enum  {DETONATION, EXPLOSION} 

var status : int 

# TODO: Arreglar estos sistemas de IA, de momento me sirve apoyarme en process, pero es un sistema muy deficiente.
func _process(_delta: float) -> void:
	_bomb_controller()

func _bomb_controller() -> void:
	if ActionQueue.in_process == true:
		return
	if actor == null: return
	if actor.properties.can_act == false:
		return

	var cmd_ignition : Command = CommandIgnition.new(actor)
	var cmd_explotion : Command = CommandExplotion.new(actor)

	match status:
		DETONATION:
			ActionQueue.add_command(cmd_ignition)
			status += 1
		EXPLOSION:
			ActionQueue.add_command(cmd_explotion)
