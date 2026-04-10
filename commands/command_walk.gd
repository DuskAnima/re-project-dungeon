extends Command
class_name CommandWalk

## Variable de inicialización para origen del movimiento
var from : Vector2i 
## Variable de inicialización para dirección del movimiento
var dir : Vector2i
## Tween que determina el trayecto del movimiento en grid
var tween : Tween
## Velocidad de desplazamiento entre tiles
var tween_speed : float = 0.2

## Coste 1. Command Move requiere recibir al actor de la acción, posición actual de grid y la constante de dirección Vector2i.
## Primero ejecuta CommandFace, el cual toma al actor y la dirección para asignar la orientación lógica de la entidad
## (face_direction). Luego ejecuta CommandMovo, el cual toma al actor, la posición lógica (grid_pos) la dirección
## para determinar qué entidad se mueve y en qué dirección.
func _init(_act : Entity, _form, _dir : Vector2i) -> void:
	act = _act
	from = _form
	dir = _dir
	
func execute() -> void:
	# Grid new position
	var to : Vector2i = from + dir
	var cmd_face := CommandFace.new(act, dir)
	
	start()
	
	if not GridManager.can_move(act, from, to):
		ActionQueue.add_wrapped_command(cmd_face)
		time_cost = 0
		finish()
		return
	
	var cmd_move := CommandMove.new(act, dir)
	ActionQueue.add_wrapped_command(cmd_move)
	ActionQueue.add_wrapped_command(cmd_face)
	
	finish()

func _set_time_cost() -> float:
	return 1
