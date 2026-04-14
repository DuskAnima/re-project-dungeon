extends Command
class_name CommandIgnition

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var animation : AnimatedSprite2D = act.animations.play_explotion()
	start()
	animation.play("ignition")
	await animation.animation_finished
	finish()

func _set_time_cost() -> float:
	return 1
## Es necesario declarar el coste de tiempo con un return de un float.
