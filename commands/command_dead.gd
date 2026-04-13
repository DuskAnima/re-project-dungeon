extends Command
class_name CommandDead

func _init(_act : Entity) -> void:
	pass

func execute() -> void:
	GameManager.kill_entity()
## La ejecución debe ser implementada. Siempre debe llamarse start() al comienzo de la implementación y finish() al
## final:
	
func _set_time_cost() -> float:
	return 0
