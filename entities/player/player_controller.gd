extends Node

var player : Entity


func move(target: Vector2i) -> void:
	CommandMove.new(player, target)

func _unhandled_input(event: InputEvent) -> void:
	if player.is_controllable():
		var direction : Vector2i = _get_direction(event)
		if direction != Vector2i.ZERO:
			move(direction)

func _get_direction(movement : InputEvent) -> Vector2i:
	if movement.is_action_pressed("down"): return Vector2i.DOWN
	if movement.is_action_pressed("up"): return Vector2i.UP
	if movement.is_action_pressed("left"): return Vector2i.LEFT
	if movement.is_action_pressed("right"): return Vector2i.RIGHT
	else: return Vector2i.ZERO
