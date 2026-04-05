extends Command
class_name CommandFace

var dir : Vector2i

## Coste 0, debe ser instanciada por otro comando. _act = Entidad a posiciónar. _dir = Dirección a mirar. 
func _init(_act : Entity, _dir : Vector2i) -> void:
	act = _act
	dir = _dir

func execute() -> void:
	# Accede a la referencia de la propiedad que almacena el Vector2 de dirección 
	var face_direction := act.properties.face_direction
	# Toma el Vector2i de la posición a la cual se desea mirar y la del origen de la entidad mirando para calcular la dirección 
	# Asigna el resultado a la variable de dirección.
	start()
	match dir:
		Vector2i.UP:
			face_direction = dir
			act.animations.play_movement("up")
		Vector2i.DOWN:
			face_direction = dir
			act.animations.play_movement("down")
		Vector2i.LEFT:
			face_direction = dir
			act.animations.play_movement("left")
		Vector2i.RIGHT:
			face_direction = dir
			act.animations.play_movement("right")
		_:
			face_direction = face_direction
	finish()

func _set_time_cost() -> float:
	return 0
