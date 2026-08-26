extends Command
class_name CommandSpawn

var grid_pos : Vector2i 
var spawned : Entity

func _init(_act : Entity, _pos : Vector2i, _spawned: Entity) -> void:
	act = _act
	grid_pos = _pos
	spawned = _spawned

func execute() -> void:
	start()
	spawned.set_entity_owner(act)
	spawned.set_grid_position(grid_pos)
	GridManager.register_actor(spawned)
	GameManager.entities_node.add_child(spawned)
	GameManager.register_controller(spawned)
	TurnSystem.register_spawned_actor(spawned)
	finish()

func _set_time_cost() -> float:
	return 0
