@tool
extends Node

func _ready():
	if not Engine.is_editor_hint():
		return

	var dummy_actor := Entity.new()
	dummy_actor.grid_pos = Vector2i(0, 0)

	var cmd := CommandMove.new(dummy_actor, Vector2i(1, 0))
	ActionQueue.add_command(cmd)
