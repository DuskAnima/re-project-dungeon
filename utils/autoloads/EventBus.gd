extends Node

func _ready() -> void:
	GridManager.entity_moved.connect(grid_catcher)
	
func grid_catcher(_actor: Entity, _grid_pos: Vector2i) -> void:
	pass
	#prints(actor.grid_pos,actor.position)
	
