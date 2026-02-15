extends Command
class_name CommandFaceDirection

var act : Entity
var from : Vector2i
var to : Vector2i

func _init(_act : Entity,  _from : Variant, _to : Variant) -> void:
	act = _act
	from = _from
	to = _to

func execute() -> void:
	var result : Vector2i = to - from
	match result:
		Vector2i.UP:
			act.direction = result
		Vector2i.DOWN:
			act.direction = result
		Vector2i.LEFT:
			act.direction = result
		Vector2i.RIGHT:
			act.direction = result
		_:
			act.direction = act.direction
	finish()

func _set_time_cost() -> float:
	return 0
