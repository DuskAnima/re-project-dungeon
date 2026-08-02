extends Command
class_name CommandFace

var dir : Vector2i
## Coste 0, debe ser instanciada por otro comando. _act = Entidad a posiciónar. _dir = Dirección a mirar. 
func _init(_act : Entity, _dir : Vector2i) -> void:
	act = _act
	dir = _dir

func execute() -> void:

	start()
	
	# 1. Envía la dirección deseada para animarla
	act.animations.face_to_animation(dir)
	# 2. Actualiza la propiedad de dirección actual a la que se está mirandoy
	act.properties.face_direction = dir

	finish()

func _set_time_cost() -> float:
	return 0
