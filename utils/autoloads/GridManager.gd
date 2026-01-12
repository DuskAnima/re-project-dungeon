extends Node

const cell_size = 32

signal entity_moved(actor, to)

## Establece el estado inicial de entidades en el grid: 
## _grid_snap(), _act.grid_pos
func grid_setup(_act: Entity) -> void:
	var pos : Vector2 = _act.position # Obtiene posición global
	pos = _grid_snap(pos) # Hace snap en el grid
	_act.grid_pos = _world_to_grid(pos) # Registra la posición de grid en las propiedades de la Entity

## FALTA IMPLEMENTACIÓN. Fuente de verdad para llevar a cabo el movimiento.
func can_move(_act: Entity, _from: Vector2i, _to: Vector2i) -> bool:
	return true

## Función que resuelve el movimiento de una entidad. Requiere unidad a mover (Entity), posición 
## source (V2i) y posición target (V2i). Solo debe ser usada por CommandMove.
func move_entity(_act: Entity, _from: Vector2i, _to: Vector2i) -> void:
	_act.grid_pos = _to
	_act.position = _grid_to_world(_act.grid_pos)
	entity_moved.emit(_act, _to)

## Multiplica la posición de grid (V2i) por el cell_size para calcular posición global.
func _grid_to_world(grid_pos : Vector2i) -> Vector2:
	return grid_pos * cell_size

## Divide la posición global (V2) por el cell_size y luego redondea para calcular posición de grid.
func _world_to_grid(pos : Vector2) -> Vector2i:
	return round(pos / cell_size)

## Determina que el sprite será encajado dentro de su casilla de grid
func _grid_snap(pos : Vector2) -> Vector2:
	var grid_pos = _world_to_grid(pos)
	return _grid_to_world(grid_pos)
