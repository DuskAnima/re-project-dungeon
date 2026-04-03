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

func is_path_blocked(grid_position : Vector2i) -> bool:
	tile_data = get_cell_tile_data(grid_position)
	if tile_data == null:
		push_error("No existe tile en la posición ", grid_position, "instancia es Null")
		return true
	return tile_data.get_custom_data("is_solid")
	
	
	#print(get_cell_tile_data(GameManager.actors[0].properties.grid_pos))
