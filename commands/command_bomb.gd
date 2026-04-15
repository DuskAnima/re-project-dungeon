extends Command
class_name CommandSetBomb

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var bomb : Bomb = Bomb.new()
	var bomb_position : Vector2i = act.properties.grid_pos + act.properties.face_direction
	start()
	print(bomb_position)
	var bomb_spawn : Command = CommandSpawn.new(bomb, bomb_position) 
	ActionQueue.add_wrapped_command(bomb_spawn)
	finish()

func _set_time_cost() -> float:
	return 0.5
## Es necesario declarar el coste de tiempo con un return de un float.
