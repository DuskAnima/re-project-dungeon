extends Command
class_name CommandTarget

var command : Command 
var visual_target : PackedScene = preload("uid://dbcfwbr3s8brp")
var input : String

func _init(_act : Entity, _command: Command, _input : String) -> void:
	act = _act
	command = _command
	input = _input

func execute() -> void:
	#var direction_string : String =  DIR[act.properties.face_direction]
	var direction_vector : Vector2i 
	var target_display : Vector2i 
	var target : Sprite2D = visual_target.instantiate()

	start()

	act.add_child(target)
	while not Input.is_action_pressed(input):
		direction_vector = act.properties.grid_pos * act.properties.face_direction
		target_display = direction_vector * 2
		target.position = GridManager._world_to_grid(target_display)
		continue

	ActionQueue.add_wrapped_command(command)

	finish()

func _set_time_cost() -> float:
	return 0
## Es necesario declarar el coste de tiempo con un return de un float.
