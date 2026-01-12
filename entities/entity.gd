extends Node2D
class_name Entity

var grid_pos : Vector2i 
@export var speed : float

func _enter_tree() -> void:
	GameManager.entity_setup(self)
	_center_sprite()

func is_controllable() -> bool:
	return false

func can_be_moved() -> bool:
	return true

func _center_sprite() -> void:
	var sprite : Sprite2D = get_node("Sprite2D")
	sprite.centered = false

func _to_string() -> String:
	return "entity"
