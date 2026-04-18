extends Command
class_name CommandSetBomb

var bomb_scene : PackedScene = preload("uid://bso8g0gkgeipa")

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var bomb : Bomb = bomb_scene.instantiate()
	var bomb_position : Vector2i = act.properties.grid_pos + act.properties.face_direction
	start()
	var bomb_spawn : Command = CommandSpawn.new(bomb, bomb_position, act)
	ActionQueue.add_wrapped_command(bomb_spawn)
	finish()

func _set_time_cost() -> float:
	return 0.1
## Es necesario declarar el coste de tiempo con un return de un float.
