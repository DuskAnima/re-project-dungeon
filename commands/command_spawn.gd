extends Command
class_name CommandSpawn

var grid_pos : Vector2i 
var owner : Entity

func _init(_act : Entity, _pos : Vector2i, _owner: Entity) -> void:
	act = _act
	grid_pos = _pos
	owner = _owner

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
