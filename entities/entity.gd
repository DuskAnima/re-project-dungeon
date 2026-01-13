extends Node2D
class_name Entity

var can_act : bool = false
var is_controllable : bool = false
var initiative_variation : bool = true

var grid_pos : Vector2i 

@export var initiative : float

func set_controllable(switch: bool) -> void:
	is_controllable = switch

func set_can_act(switch: bool) -> void:
	can_act = switch

func _enter_tree() -> void:
	GameManager.entity_setup(self)
	_decenter_sprite()

func _decenter_sprite() -> void:
	var sprite : Sprite2D = get_node("Sprite2D")
	sprite.centered = false

func _to_string() -> String:
	return "entity"
