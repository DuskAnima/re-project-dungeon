extends Node2D
class_name Entity

# Flags
var can_act : bool = false
var is_controllable : bool = false
var direction : Vector2i

# Grid Position
var grid_pos : Vector2i 

# Stat Resource
@export var stats : Stats

## Establece la propiedad que permite que el jugador pueda controlar a una entidad
func set_controllable(switch: bool) -> void:
	is_controllable = switch
	
## Establece la propiedad que permite que una entidad pueda tomar su turno para actuar.
func set_can_act(switch: bool) -> void:
	can_act = switch

## Al entrar al arbol 
func _ready() -> void:
	GameManager.entity_setup(self)
	_decenter_sprite()
	ready_hook()

## Quita la propiedad "Sprite2D.center"
func _decenter_sprite() -> void:
	var sprite : Sprite2D = get_node("Sprite2D")
	sprite.centered = false

## Identificación para debugging
func _to_string() -> String:
	return "entity"

func ready_hook() -> void:
	pass
