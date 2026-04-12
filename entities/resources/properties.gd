extends Resource
class_name Properties

@export_enum("player", "ai", "object") var entity_kind : String
@export var grid_pos : Vector2i 
@export var turn_active : bool = false
@export var is_controllable : bool = false
@export var can_act : bool = false
@export var face_direction : Vector2
@export var time : float = TimeManager.base_time
