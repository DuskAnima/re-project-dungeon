extends Command
class_name CommandPush

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var push_at : Vector2i = act.properties.grid_pos + act.properties.face_direction
	var other_act : Entity = GridManager.get_entity_from_grid(push_at)
	var move_cmd : Command = CommandMove.new(other_act, push_at, act.properties.face_direction)

	if other_act == null:
		finish()
		return

	start()

	ActionQueue.add_wrapped_command(move_cmd)

	finish()

func _set_time_cost() -> float:
	return 1
