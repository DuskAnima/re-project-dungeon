extends Node
class_name AiController

var actor : Entity

func _ready() -> void:
	actor = get_parent()
	owner = actor

func movement_manager() -> void:
	if actor == null: return
	if actor.properties.can_act == false:
		return

	var dir : Vector2i = direction.pick_random()
	if dir == Vector2i.ZERO:
		return

	var cmd := CommandWalk.new(actor, dir)
	ActionQueue.add_command(cmd)


var direction = [
	Vector2i.DOWN,
	Vector2i.UP,
	Vector2i.LEFT,
	Vector2i.RIGHT,
	Vector2i.ZERO
]

func _process(_delta: float) -> void:
	movement_manager()
