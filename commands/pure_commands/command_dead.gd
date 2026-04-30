extends Command
class_name CommandDead

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	start()
	GameManager.kill_entity(act)
	finish()

func _set_time_cost() -> float:
	return 0
