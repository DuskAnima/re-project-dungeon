extends Command
class_name CommandFace

var dir : Vector2i
## Coste 0, debe ser instanciada por otro comando. _act = Entidad a posiciónar. _dir = Dirección a mirar. 
func _init(_act : Entity, _dir : Vector2i) -> void:
	act = _act
	dir = _dir

func execute() -> void:

	start()
	act.properties.face_direction = dir
	match dir:
		Vector2i.UP:
			act.animations.play_movement("up")
		Vector2i.DOWN:
			act.animations.play_movement("down")
		Vector2i.LEFT:
			act.animations.play_movement("left")
		Vector2i.RIGHT:
			act.animations.play_movement("right")

	finish()

func _set_time_cost() -> float:
	return 0
