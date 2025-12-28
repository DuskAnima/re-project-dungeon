extends Command
class_name CommandMove

var target : Vector2i
var from : Vector2i

func _init(_actor : Entity, _target : Vector2i) -> void:
	setup(actor)
	target = target

func execute() -> void:
	pass
