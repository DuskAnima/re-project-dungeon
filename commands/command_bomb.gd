extends Command
class_name CommandBomb

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	start()

	finish()

func _set_time_cost() -> float:
	return 1
## Es necesario declarar el coste de tiempo con un return de un float.
