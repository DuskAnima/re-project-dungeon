extends TileMapLayer
class_name Terrain
## La instancia de terrain (TileMapLayer) debe ser transformada a x = -16 e y = -16, esta transformación mantiene 
## la consistencia visual y lógica de los tiles sin romper nada. Transformar la posición de la instancia 
## de terrain en cantidades mayores genera inconsistencias visuales, ya que la información de cada tile 
## se almacena en la posición global independiente de su posicionamiento visual. Es decir, podría transformar 
## la instancia de TileMapLayer x -2000 (por ejemplo) y el objeto tile seguiría posicionado en su coordenada
## logica desde el punto 0.0 y no del espacio visual que use. Esto no se altera ni siquiera alterando la clase.
var tile_data : TileData

func _ready() -> void:
	GridManager.terrain_setup(self)

## Función que retorna si un camino está bloqueado. Retorna "true" si el camino está bloqueado.
func is_path_blocked(_grid_position : Vector2i) -> bool:
	return _is_tile_solid(_grid_position) or _is_tile_occupied(_grid_position)

## Función que revisa los tiles ocupados por entidades, retorna "true" si el tile está ocupado
func _is_tile_occupied(_grid_position : Vector2i) -> bool:
	if GridManager.grid_occupation.has(_grid_position):
		return true
	return false

## Función que revisa los tiles con custom_data "is_solid", retorna "true" si el tile es sólido.
func _is_tile_solid(_grid_position : Vector2i) -> bool:
	tile_data = get_cell_tile_data(_grid_position)
	if tile_data == null:
		push_error("No existe tile en la posición ", _grid_position, "instancia es Null")
		return true
	return tile_data.get_custom_data("is_solid")

func tile_fetcher(_grid_position: Vector2i) -> void:
	var tile_id : int = get_cell_source_id(_grid_position)
	var terrain_tile_data : TileData = get_cell_tile_data(_grid_position)
	var tile_atlas_coords : Vector2i = get_cell_atlas_coords(_grid_position)
	var tile_information : bool = terrain_tile_data.get_custom_data("can_break")
	if tile_information:
		var tile_breaker : Vector2i = tile_atlas_coords + Vector2i(1,0)
		set_cell(_grid_position, tile_id, tile_breaker)
