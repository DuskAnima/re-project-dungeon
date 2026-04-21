extends Command

func _init(_act : Entity) -> void:
	act = _act

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
