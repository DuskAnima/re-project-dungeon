extends Command
class_name CommandBomb

var bomb : Bomb

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	start()
	bomb = Bomb.new()
	GameManager.entities_node.add_child(bomb)
	finish()

func _set_time_cost() -> float:
	return 0.5
## Es necesario declarar el coste de tiempo con un return de un float.
