extends Controller
class_name AiController


# TODO: Arreglar estos sistemas de IA, de momento me sirve apoyarme en process, pero es un sistema muy deficiente.
func _process(_delta: float) -> void:
	if _npc_action_check():
		movement_manager()

func movement_manager() -> void:

	var dir : Vector2i = direction.pick_random()
	var from : Vector2i = actor.properties.grid_pos
	if dir == Vector2i.ZERO:
		return

	var cmd := CommandWalk.new(actor, from, dir)
	ActionQueue.add_command(cmd)


var direction = [
	Vector2i.DOWN,
	Vector2i.UP,
	Vector2i.LEFT,
	Vector2i.RIGHT,
	Vector2i.ZERO
]
