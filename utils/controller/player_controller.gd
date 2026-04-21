extends Controller
class_name PlayerController

func _unhandled_input(_event: InputEvent) -> void:
	if _player_action_check():
		movement_manager(_event)
		_action()

func movement_manager(_event) -> void:
	var dir := _get_direction(_event)
	if dir == Vector2i.ZERO:
		return

	var cmd := CommandWalk.new(actor, dir)
	ActionQueue.add_command(cmd)

func _get_direction(movement) -> Vector2i:
	if movement.is_action_pressed("down"): return Vector2i.DOWN
	elif movement.is_action_pressed("up"): return Vector2i.UP
	elif movement.is_action_pressed("left"): return Vector2i.LEFT
	elif  movement.is_action_pressed("right"): return Vector2i.RIGHT

	else: return Vector2i.ZERO
	
func _action() -> void:
	if Input.is_action_just_pressed("command1"):
		var cmd : Command = CommandSetBomb.new(owner)
		var target : Command = CommandTarget.new(owner, cmd, "command1")
		ActionQueue.add_command(target)
	
	elif Input.is_action_just_pressed("command2"):
		var cmd : Command = CommandPush.new(owner)
		ActionQueue.add_command(cmd)
