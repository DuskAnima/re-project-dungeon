extends Controller
class_name ObjectController

enum  {DETONATION, EXPLOSION} 

var status : int 

func _process(delta: float) -> void:
	_bomb_controller()

func _bomb_controller() -> void:
	if ActionQueue.in_process == true:
		return
	if actor == null: return
	if actor.properties.can_act == false:
		return

	var cmd : Command = CommandIgnition.new(actor)
	
	ActionQueue.add_command(cmd)
	match status:
		DETONATION:
			ActionQueue.add_command(cmd)
			status += 1
		EXPLOSION:
			pass
