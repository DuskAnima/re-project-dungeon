extends TileMapLayer
## La instancia de terrain (TileMapLayer) debe ser transformada a x = -16 e y = -16, esta transformación mantiene 
## la consistencia visual y lógica de los tiles sin romper nada. Transformar la posición de la instancia 
## de terrain en cantidades mayores genera inconsistencias visuales, ya que la información de cada tile 
## se almacena en la posición global independiente de su posicionamiento visual. Es decir, podría transformar 
## la instancia de TileMapLayer x -2000 (por ejemplo) y el objeto tile seguiría posicionado en su coordenada
## logica desde el punto 0.0 y no del espacio visual que use. Esto no se altera ni siquiera alterando la clase.

func _process(_delta: float) -> void:
	tile_info()

func tile_info() -> void:
	pass
	#print(get_cell_tile_data(GameManager.actors[0].properties.grid_pos))
