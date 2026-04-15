extends Command
class_name CommandSpawn

var grid_pos : Vector2i 

func _init(_act : Entity, _pos : Vector2i) -> void:
	act = _act
	grid_pos = _pos

func execute() -> void:
	start()
	act = act.get_script().new()
	GameManager.entities_node.add_child(act)
	GameManager.entity_setup(act)
	act.properties.grid_pos = grid_pos
	print(act)
	print(grid_pos)
	print(act.properties.grid_pos)
	finish()

func _set_time_cost() -> float:
	return 0
## Es necesario declarar el coste de tiempo con un return de un float.
