extends Command
class_name CommandExplode

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	start()
	act.animations.play_explotion("ignition")
## La ejecución debe ser implementada. Siempre debe llamarse start() al comienzo de la implementación y 
## finish() al final.
	finish()

func _set_time_cost() -> float:
	return 1
## Es necesario declarar el coste de tiempo con un return de un float.
