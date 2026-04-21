extends Command
class_name CommandExplotion

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var cmd : Command = CommandDead.new(act)
	start()
	ActionQueue.add_wrapped_command(cmd)
	var animation : AnimatedSprite2D = act.animations.play_explotion()
	animation.play("EXPLOTION")
	var surrounding_tiles : Array[Vector2i] = GridManager.get_surrounding_tiles_square(act.properties.grid_pos)
	for tiles in surrounding_tiles:
		var actor : Entity = GridManager.get_entity_from_grid(tiles)
		if actor == null or act == actor:
			print(actor, " se salvó")
			continue
		print(actor, " explotó")
		GameManager.kill_entity(actor)
	await animation.animation_finished
	finish()

func _set_time_cost() -> float:
	return 1
