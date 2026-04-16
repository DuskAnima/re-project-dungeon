extends Controller
class_name ObjectController

enum  {IDLE, DETONATION, EXPLOSION} 

var status : int 

# TODO: Arreglar estos sistemas de IA, de momento me sirve apoyarme en process, pero es un sistema muy deficiente.
func _process(_delta: float) -> void:
	if _npc_action_check():
		_bomb_controller()

func _bomb_controller() -> void:
	var cmd_ignition : Command = CommandIgnition.new(actor)
	var cmd_explotion : Command = CommandExplotion.new(actor)
	print(status)
	match status:
		IDLE:
			status +=1
		DETONATION:
			ActionQueue.add_command(cmd_ignition)
			status += 1
		EXPLOSION:
			ActionQueue.add_command(cmd_explotion)
