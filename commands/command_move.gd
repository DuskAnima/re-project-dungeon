extends Command
class_name CommandMove

var from : Vector2i:
	get:
		return _source
	set(value):
		_source = value
var to : Vector2i:
	get:
		return _target
	set(value):
		_target = value

func _init(act: Entity, from_: Vector2i, to_: Vector2i) -> void:
	super(act, from_, to_)

func execute() -> void:
	print("command_move")
	is_executing = true

	if actor == null:
		push_error("Command Move: Actor is Null")
		finish()
		return

	from = actor.grid_pos
	if not GridManager.can_move(actor, from, to):
		finish()
		return
	GridManager.move_entity(actor, from, to)
	finish()
