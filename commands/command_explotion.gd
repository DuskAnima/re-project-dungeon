extends Command
class_name CommandExplotion

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	start()
	var animation : AnimatedSprite2D = act.animations.play_explotion()
	animation.play("explotion")
	await animation.animation_finished
	var cmd : Command = CommandDead.new(act)
	ActionQueue.add_wrapped_command(cmd)
	finish()

func _set_time_cost() -> float:
	return 1
## Es necesario declarar el coste de tiempo con un return de un float.
