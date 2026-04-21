extends Command
class_name CommandExplotion

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var cmd_dead : Command = CommandDead.new(act) # Prepara la muerte de la entidad
	
	start()
	
	ActionQueue.add_wrapped_command(cmd_dead) # Agrega la muerte de la entidad a la cola
	var animation : AnimatedSprite2D = act.animations.play_explotion() # Llama la animación de explosión
	animation.play("EXPLOTION") # Reproduce la explosión
	# Obtiene las posiciones circundantes al origen de la explosión
	var surrounding_tiles : Array[Vector2i] = GridManager.get_surrounding_tiles_square(act.properties.grid_pos)
	# Itera por los tiles para poder identificar cuales posee entidades
	for tiles in surrounding_tiles:
		var actor : Entity = GridManager.get_entity_from_grid(tiles)
		if actor == null or act == actor:
			continue
		ActionQueue.add_wrapped_command(CommandDead.new(actor)) # Las entidades detectadas mueren (Requiere refactorización)

	await animation.animation_finished
	
	finish()

func _set_time_cost() -> float:
	return 1
