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
	act.set_grid_position(grid_pos)
	GameManager.entities_node.add_child(act)
	act.set_entity_owner(owner)
	TurnSystem.register_spawned_actor(act)
	GameManager.entity_setup(act) 
	GameManager.register_controller(act)
	finish()

func _set_time_cost() -> float:
	return 0
