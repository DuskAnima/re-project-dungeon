extends Command
class_name CommandIgnition

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	start()
	await act.animations.explotion_animation(1)
	finish()

func _set_time_cost() -> float:
	return 2
