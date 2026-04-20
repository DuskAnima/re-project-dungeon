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
	var animation : AnimatedSprite2D = act.animations.play_movement()
	match dir:
		Vector2i.UP:
			animation.play("FACE_UP")
		Vector2i.DOWN:
			animation.play("FACE_DOWN")
		Vector2i.LEFT:
			animation.play("FACE_LEFT")
		Vector2i.RIGHT:
			animation.play("FACE_RIGHT")

	finish()

func _set_time_cost() -> float:
	return 0
