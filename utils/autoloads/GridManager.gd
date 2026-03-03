extends Node

## Tamaño de las celdas del grid.
const cell_size : int = 32
## Referencia a las diferentes entidades registradas para poder acceder a sus posiciones
var actors : Array[Entity] = GameManager.actors
## Tween que determina el trayecto del movimiento en grid
var tween : Tween
## Velocidad de desplazamiento entre tiles
var tween_speed : float = 0.2

## Establece el estado inicial de entidades en el grid: 
## _grid_snap(), _act.grid_pos
func grid_setup(_act: Entity) -> void:
	var pos : Vector2 = _act.position # Obtiene posición global
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
	_act.grid_pos = _to

func grid_movement(_act: Entity, _from : Vector2, _to : Vector2) -> void:
	tween = _act.create_tween()
	tween.tween_property(_act, "position", _to, tween_speed)

## Multiplica la posición de grid (V2i) por el cell_size para calcular posición global.
func _grid_to_world(grid_pos : Vector2i) -> Vector2:
	return grid_pos * cell_size

## Divide la posición global (V2) por el cell_size y luego redondea para calcular posición de grid.
func _world_to_grid(pos : Vector2) -> Vector2i:
	return round(pos / cell_size)

## Determina que el sprite será encajado dentro de su casilla de grid
func _grid_snap(_act: Entity, pos : Vector2) -> void:
	var grid_pos = _world_to_grid(pos)
	_act.position = _grid_to_world(grid_pos)
