extends Node
class_name AiController

var actor : Entity = null

func _ready() -> void:
	GameManager.register_ai_controller(self)

func set_actor(_act : Entity) -> void:
	actor = _act

func movement_manager() -> void:
	if actor == null: return
	if actor.properties.can_act == false: 
		print("CAN'T ACT")
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
