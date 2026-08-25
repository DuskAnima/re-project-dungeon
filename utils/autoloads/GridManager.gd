extends Node

var overlay_layer : TileMapLayer

## Tamaño de las celdas del grid.
const cell_size : int = 32
## Valor constante equivalente a Vector2i.MIN que sirve como convención de eliminación de entidad del grid.
const ENTITY_DELETE_FLAG : Vector2i = Vector2i.MIN
## Referencia a las diferentes entidades registradas para poder acceder a sus posiciones
var grid_occupation : Dictionary[Vector2i, Array]
## Referencia al terreno de juego para poder operar sobre él.
var terrain : Terrain
## Tween que determina el trayecto del movimiento en grid
var tween : Tween
## Velocidad de desplazamiento entre tiles
var tween_speed : float = 0.45

func highlight_area(tiles: Array[Vector2i]) -> void:
	overlay_layer.clear()
	for tile in tiles:
		overlay_layer.set_cell(tile, )

## Establece el estado inicial de entidades en el grid
func grid_setup(_act: Entity) -> void:
	if GameManager.game_status == GameManager.BOOT: #Ejecución en compile time.
		var pos : Vector2 = _act.position # Obtiene posición global
		_grid_snap(_act, pos) # Hace snapping a Entity en el grid
		# Solo cuando _update_grid es llamado desde grid setup from y to son llamados de esta forma.
		_update_grid(_act, _world_to_grid(_act.position), _world_to_grid(_act.position)) # Registra la posición de grid en las propiedades de Entity
	else:
		# Esta sección es para settear Entities en runtime.
		_update_grid(_act, _act.get_grid_position(), _act.get_grid_position()) # Establece propiedaes lógicas
		_act.position = _grid_to_world(_act.get_grid_position()) # Las actualiza en valores globales

func terrain_setup(_terrain: TileMapLayer) -> void:
	terrain = _terrain

## Fuente de verdad para llevar a cabo movimientos.
func is_tile_free(_act: Entity, _from: Vector2i, _to: Vector2i) -> bool:
	if terrain.is_path_blocked(_to):
		return false
	return true

## Función que resuelve el movimiento de una entidad. Requiere unidad a mover (Entity) y posición 
##  target (V2i). Solo debe ser usada por CommandMove y setup_entity()
func _update_grid(_act: Entity, _from : Vector2i, _to: Vector2i) -> void:
	if _to == ENTITY_DELETE_FLAG: # SI posee flag de eliminación
		grid_occupation.erase(_from) # Saca a la entidad del grid
		return
	if _from != _to: # Si el origen es diferente del destino
		grid_occupation.erase(_from) # Elimina el origen
	_act.set_grid_position(_to) # A la entidad se le actualiza su posición lógica
	grid_occupation.get_or_add(_to, []) # Luego agrega u obtiene la posición. Si la agrega le da por defecto un array vacío
	grid_occupation[_to].append(_act) # A la posición se le asigna la entidad
	terrain.process_tile(_to) # Detona la lógica del tile habitado

func move_entity(_act: Entity, from: Vector2i, to: Vector2i) -> void:
	# 1. Calcula posiciones globales
	var global_from : Vector2 = _grid_to_world(from)
	var global_to : Vector2 = _grid_to_world(to)
	# 2. Crea y ejecuta el tween
	var grid_movement_tween : Tween = _grid_movement(_act, global_from, global_to)
	await grid_movement_tween.finished
	# 3. Actualiza el grid lógico
	_update_grid(_act, from, to)

## Función que retorna el tween de movimiento standard.
func _grid_movement(_act: Entity, _from : Vector2, _to : Vector2) -> Tween:
	if _act == null:
		return
	tween = _act.create_tween()
	tween.tween_property(_act, "position", _to, tween_speed)
	return tween

func get_surrounding_tiles_square(_grid_position : Vector2i) -> Array[Vector2i]:
	var square : Array[Vector2i] = [Vector2i(1,1),Vector2i(0,1),Vector2i(-1,1),
									Vector2i(1,0),Vector2i(0,0),Vector2i(-1,0),
									Vector2i(1,-1),Vector2i(0,-1),Vector2i(-1,-1)]
	var area : Array[Vector2i]
	for i in square:
		i = i+_grid_position
		area.append(i)
	return area

## Recibe una posición de grid y retorna la Entity que esté en esa posición.
func get_entity_from_grid(grid_position : Vector2i) -> Entity:
	for tile in grid_occupation:
		if tile == grid_position:
			return grid_occupation[grid_position][0]
	return null

## Multiplica la posición de grid (V2i) por el cell_size para calcular posición global.
func _grid_to_world(grid_pos : Vector2i) -> Vector2:
	var global_pos : Vector2 = grid_pos * cell_size
	return global_pos

## Divide la posición global (V2) por el cell_size y luego redondea para calcular posición de grid.
func _world_to_grid(pos : Vector2) -> Vector2i:
	var round_pos : Vector2i = round(pos / cell_size)
	return round_pos

## Determina que el sprite será encajado dentro de su casilla de grid
func _grid_snap(_act: Entity, pos : Vector2) -> void:
	var grid_pos = _world_to_grid(pos)
	_act.position = _grid_to_world(grid_pos)
