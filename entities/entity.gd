extends Node2D
class_name Entity

# Flags
## Resource que almacena referencias a las animaciones y las ejecuta
var animations : Animations = Animations.new(self)
## Diccionario de referencia para los diferentes nodos de animaciones
@export var animated_sprites : Dictionary[String, AnimatedSprite2D]
## General logic properties of entities (grid_pos, face_direction, is_controlable)
@export var properties : Properties
## General stats of entities (initiative)
@export var stats : Stats

## Establece la propiedad que permite que el jugador pueda controlar a una entidad
func set_controllable(switch: bool) -> void: properties.is_controllable = switch
	
## Establece la propiedad que permite que una entidad pueda tomar su turno para actuar.
func set_can_act(switch: bool) -> void: properties.can_act = switch

func get_time() -> float: return properties.time
func set_time(time: float) -> void: properties.time -= time
	

## Al entrar al arbol 
func _ready() -> void:
	GameManager.entity_setup(self)
	ready_hook()

## Identificación para debugging
func _to_string() -> String:
	return "entity"

func ready_hook() -> void:
	pass
