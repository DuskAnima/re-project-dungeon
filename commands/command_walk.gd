extends Command
class_name CommandWalk

## Variable de inicialización para origen del movimiento

## Variable de inicialización para dirección del movimiento
var dir : Vector2i
## Tween que determina el trayecto del movimiento en grid
var tween : Tween
## Velocidad de desplazamiento entre tiles
var tween_speed : float = 0.2

## Coste 1. Command Move requiere recibir al actor de la acción, posición actual de grid y la constante de dirección.
## Vector2i Primero ejecuta CommandFace, el cual toma al actor y la dirección para asignar la orientación lógica de la 
## entidad (face_direction). Luego ejecuta CommandMovo, el cual toma al actor, la posición lógica (grid_pos) la dirección
## para determinar qué entidad se mueve y en qué dirección.
func _init(_act : Entity, _dir : Vector2i) -> void:
	act = _act
	dir = _dir
	
func execute() -> void:
	# Grid origin
	var from : Vector2i  = act.properties.grid_pos
	# Grid new position
	var to : Vector2i = from + dir
	var cmd_face := CommandFace.new(act, dir)
	
	start()
	
	if not GridManager.is_tile_free(act, from, to):
		ActionQueue.add_wrapped_command(cmd_face)
		time_cost = 0

		finish()
		return
	var cmd_move := CommandMove.new(act, from, dir)
	var animation : AnimatedSprite2D = act.animations.play_movement()

	match dir:
		Vector2i.UP:
			animation.play("MOVE_UP")
		Vector2i.DOWN:
			animation.play("MOVE_DOWN")
		Vector2i.LEFT:
			animation.play("MOVE_LEFT")
		Vector2i.RIGHT:
			animation.play("MOVE_RIGHT")

	ActionQueue.add_wrapped_command(cmd_move)
	ActionQueue.add_wrapped_command(cmd_face)
	
	finish()

func _set_time_cost() -> float:
	return 1
