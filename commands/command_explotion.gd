extends Command
class_name CommandExplotion

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var cmd : Command = CommandDead.new(act)
	start()
	ActionQueue.add_wrapped_command(cmd)
	var animation : AnimatedSprite2D = act.animations.play_explotion()
	animation.play("explotion")
	await animation.animation_finished
	finish()

func _set_time_cost() -> float:
	return 1
## Es necesario declarar el coste de tiempo con un return de un float.
