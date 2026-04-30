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

	GameManager.aux_node.add_child(target)
	if Input.is_action_pressed(input):
		direction_vector = act.properties.grid_pos + act.properties.face_direction
		target_display = direction_vector 
		target.position = GridManager._grid_to_world(target_display)


	ActionQueue.add_wrapped_command(command)

	finish()

func _set_time_cost() -> float:
	return 0
## Es necesario declarar el coste de tiempo con un return de un float.
