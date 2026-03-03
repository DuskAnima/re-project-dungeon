extends Command
class_name CommandWalk

## Variable de inicialización para actor
var act : Entity
## Variable de inicialización para origen del movimiento
var from : Vector2i
## Variable de inicialización para destino del movimiento
var dir : Vector2i
## Tween que determina el trayecto del movimiento en grid
var tween : Tween
## Velocidad de desplazamiento entre tiles
var tween_speed : float = 0.2

## Command Move requiere recibir al actor de la acción, posición actual de grid y posición requerida de grid.
func _init(_act : Entity,  _from : Vector2i, _dir : Vector2i) -> void:
	act = _act
	from = _from
	dir = _dir
	
func execute() -> void:
	start()
	var cmd_face := CommandFace.new(act, from, dir)
	var cmd_move := CommandMove.new(act, from, dir)
	ActionQueue.add_command(cmd_face)
	ActionQueue.add_command(cmd_move)
	finish()

func _set_time_cost() -> float:
	return 1
