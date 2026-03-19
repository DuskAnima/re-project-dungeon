extends Node

# ToDO: 
# - Bug de repetición de operación, CommandMove:
# El comando move, al depender de la intancia empaquetada del actor, genera que se opere grid_update()
# sobre información no actualizada: El flujo sería Command 1 -> grid update instantaneo -> Command init múltiple -> 
# Comand init 1 termina -> Command init 2 -> grid update sobre la operación anterior -> Command init 3.4,5 etc 
# grid update opera sobre todas las veces que se logró instanciar el Command antes que el Command init 1 terminase.

## Tamaño de las celdas del grid.
const cell_size : int = 32
## Referencia a las diferentes entidades registradas para poder acceder a sus posiciones
var actors : Array[Entity] = GameManager.actors
## Tween que determina el trayecto del movimiento en grid
var tween : Tween
## Velocidad de desplazamiento entre tiles
var tween_speed : float = 2
var counter : int = 0

## Establece el estado inicial de entidades en el grid: 
## _grid_snap(), _act.grid_pos
func grid_setup(_act: Entity) -> void:
	var pos : Vector2 = _act.position # Obtiene posición global
	prints("GridManager -> set_up actor position:", pos)
	_grid_snap(_act, pos) # Hace snapping a Entity en el grid
	update_grid(_act, _world_to_grid(_act.position)) # Registra la posición de grid en las propiedades de Entity

## FALTA IMPLEMENTACIÓN. Fuente de verdad para llevar a cabo el movimiento.
func can_move(_act: Entity, _from: Vector2i, _to: Vector2i) -> bool:
	return true

func cell_check() -> void:
	pass

## Función que resuelve el movimiento de una entidad. Requiere unidad a mover (Entity) y posición 
##  target (V2i). Solo debe ser usada por CommandMove.
func update_grid(_act: Entity, _to: Vector2i) -> void:
	counter += 1
	print(counter)
	prints("GridManager -> update_grid -> \nFROM:", _act.properties.grid_pos)
	_act.properties.grid_pos = _to
	prints("TO:", _to)

func grid_movement(_act: Entity, _from : Vector2, _to : Vector2) -> Tween:
	prints("GridManager -> grid_movement -> \nFROM:", _from)
	prints("TO:", _to)
	tween = _act.create_tween()
	tween.tween_property(_act, "position", _to, tween_speed)
	return tween

## Multiplica la posición de grid (V2i) por el cell_size para calcular posición global.
func _grid_to_world(grid_pos : Vector2i) -> Vector2:
	var global_pos : Vector2 = grid_pos * cell_size
	prints("grid_to_world -> global_position", global_pos)
	return global_pos

## Divide la posición global (V2) por el cell_size y luego redondea para calcular posición de grid.
func _world_to_grid(pos : Vector2) -> Vector2i:
	var round_pos : Vector2i = round(pos / cell_size)
	prints("world_to_grid -> grid position", round_pos)
	return round_pos

## Determina que el sprite será encajado dentro de su casilla de grid
func _grid_snap(_act: Entity, pos : Vector2) -> void:
	var grid_pos = _world_to_grid(pos)
	_act.position = _grid_to_world(grid_pos)
