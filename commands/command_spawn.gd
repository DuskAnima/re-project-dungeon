extends Command
class_name CommandSpawn

var grid_pos : Vector2i 

func _init(_act : Entity, _pos : Vector2i) -> void:
	act = _act
	grid_pos = _pos

func execute() -> void:
	start()
	GameManager.entities_node.add_child(act)
	act.properties.grid_pos = grid_pos
	GameManager.entity_setup(act)
	GameManager.register_controller()
	finish()

func _set_time_cost() -> float:
	return 0
## Es necesario declarar el coste de tiempo con un return de un float.
