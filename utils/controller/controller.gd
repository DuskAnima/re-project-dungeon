extends Node
## Controller es un nodo que originalmente debe ser inyectado como nodo hijo en Entities controlables.
## 
## El primer Entity controlable es inyectado desde GameManager._game_set_up()
class_name Controller

var actor : Entity

func _ready() -> void:
	actor = get_parent()
	owner = actor

func set_actor(_act : Entity) -> void:
	actor = _act

func _unhandled_input(event: InputEvent) -> void:
	movement_manager(event)

func movement_manager(event) -> void:
	######################## test stuff

	if actor == null: return
	if actor.properties.is_controllable == false: return
	if actor.properties.can_act == false: 
		return

	var dir := _get_direction(event)
	if dir == Vector2i.ZERO:
		return

	var cmd := CommandWalk.new(actor, dir)
	ActionQueue.add_command(cmd)


func _get_direction(movement : InputEvent) -> Vector2i:
	if movement.is_action_pressed("down"): return Vector2i.DOWN
	elif movement.is_action_pressed("up"): return Vector2i.UP
	elif movement.is_action_pressed("left"): return Vector2i.LEFT
	elif  movement.is_action_pressed("right"): return Vector2i.RIGHT
	else: return Vector2i.ZERO
