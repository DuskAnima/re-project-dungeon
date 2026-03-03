extends Command
class_name CommandFace

var act : Entity
var from : Vector2i
var to : Vector2i

## _act = Entidad a posiciónar. _from = Dirección a mirar. _to = Posición de origen. ||||||
## _from y _to son las variables de grid_pos. |||||| _to debe ser un Vector2i extra en la dirección deseada
func _init(_act : Entity,  _from : Vector2i, _to : Vector2i) -> void:
	act = _act
	from = _from
	to = _to

func execute() -> void:
	is_executing = true
	# Accede a la referencia de la propiedad que almacena el Vector2 de dirección 
	var face_direction := act.properties.face_direction
	# Toma el Vector2i de la posición a la cual se desea mirar y la del origen de la entidad mirando para calcular la dirección 
	var result : Vector2 = to - from
	# Asigna el resultado a la variable de dirección.
	start()
	match result:
		Vector2i.UP:
			face_direction = result
		Vector2i.DOWN:
			face_direction = result
		Vector2i.LEFT:
			face_direction = result
		Vector2i.RIGHT:
			face_direction = result
		_:
			face_direction = act.properties.face_direction
	finish()

func _set_time_cost() -> float:
	return 0
