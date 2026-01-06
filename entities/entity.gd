extends Node2D
class_name Entity

var grid_pos : Vector2i = Vector2i.ZERO


func is_controllable() -> bool:
	return false

func can_be_moved() -> bool:
	return true
