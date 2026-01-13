extends Node
class_name Controller

var actor : Entity = null

func _ready() -> void:
	GameManager.register_controller(self)

func set_actor(_act : Entity) -> void:
	actor = _act

func _unhandled_input(event: InputEvent) -> void:
	movement_manager(event)

func movement_manager(event) -> void:
	if actor == null: return
	if actor.is_controllable == false: return
	if actor.can_act == false: return

	var direction := _get_direction(event)
	if direction == Vector2i.ZERO:
		return

	var from := actor.grid_pos
	var to := from + direction

	var cmd := CommandMove.new(actor, from, to)
	ActionQueue.add_command(cmd)


func _get_direction(movement : InputEvent) -> Vector2i:
	if movement.is_action_pressed("down"): return Vector2i.DOWN
	elif movement.is_action_pressed("up"): return Vector2i.UP
	elif movement.is_action_pressed("left"): return Vector2i.LEFT
	elif  movement.is_action_pressed("right"): return Vector2i.RIGHT
	else: return Vector2i.ZERO
