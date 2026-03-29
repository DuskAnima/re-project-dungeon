extends Command

var src : Variant
var targ : Variant

func _init(_act : Entity,  _src : Variant = null, _targ : Variant = null) -> void:
	act = _act
	src = _src
	targ = _targ

func execute() -> void:
	
	# Casos de uso:
		# delegar a un personaje in-code
			# Establecer en ready() para obtener al personaje inicial
		# delegar a un personaje in-game
			# Sistema para que el personaje jugable delege
				# Pararse frente a la entidad, usar comando
					# (Crear targetting command?)
					# Check de si existe una entidad frente a él
						# Le pregunta a grid manager sobre las entidades que están frente a él
						
	pass
	
func _set_time_cost() -> float:
	return 1
