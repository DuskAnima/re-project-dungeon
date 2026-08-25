extends Resource
class_name Properties

@export_enum("Player", "Ai", "Object") var entity_kind : String
var owner : WeakRef
@export var grid_pos : Vector2i 
@export var is_controllable : bool = false
@export var can_act : bool = false
@export var face_direction : Vector2i = Vector2i.DOWN
@export var time : float 
