extends Controller
class_name PlayerController

func _unhandled_input(event: InputEvent) -> void:
	if _player_action_check():
		movement_manager(event)
		_action(event)
		

func movement_manager(event) -> void:
	var dir := _get_direction(event)
	var from : Vector2i = actor.properties.grid_pos
	if dir == Vector2i.ZERO:
		return

	var cmd := CommandWalk.new(actor, from, dir)
	ActionQueue.add_command(cmd)

func _get_direction(movement : InputEvent) -> Vector2i:
	if movement.is_action_pressed("down"): return Vector2i.DOWN
	elif movement.is_action_pressed("up"): return Vector2i.UP
	elif movement.is_action_pressed("left"): return Vector2i.LEFT
	elif  movement.is_action_pressed("right"): return Vector2i.RIGHT
	else: return Vector2i.ZERO
	
func _action(action : InputEvent) -> void:
	if action.is_action_pressed("action"):
		var cmd : Command = CommandSetBomb.new(owner)
		ActionQueue.add_command(cmd)
