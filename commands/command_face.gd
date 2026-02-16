extends Command
class_name CommandFaceDirection

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
	# Accede a la propiedad que almacena el Vector2i de dirección 
	var direction = act.properties.direction
	# Toma el Vector2i de la posición a la cual se desea mirar y la del origen de la entidad mirando para calcular la dirección 
	var result : Vector2i = to - from
	# Asigna el resultado a la variable de dirección.
	match result:
		Vector2i.UP:
			direction = result
		Vector2i.DOWN:
			direction = result
		Vector2i.LEFT:
			direction = result
		Vector2i.RIGHT:
			direction = result
		_:
			direction = act.direction
	finish()

func _set_time_cost() -> float:
	return 0
