@abstract
extends Node2D
class_name Entity

## Resource que almacena referencias a las animaciones y las ejecuta
var animations : Animations = Animations.new(self)
## Place holder para asignar un controller
var controller : Controller
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

func get_grid_position() -> Vector2i: return properties.grid_pos
func set_grid_position(new_pos : Vector2i) -> void: properties.grid_pos = new_pos

func get_time() -> float: return properties.time
func set_time(time: float) -> void: properties.time = time

## Retorna al actor dueño/creador de este Entity. Ejemplo: una bomba creada por player retornará al actor player
func get_entity_owner() -> Entity:
	if properties == null or properties.owner == null:
		return null
	return properties.owner.get_ref() as Entity

## Recibe un actor para firmar como dueño/creador a este Entity.[br]
## La referencia es regitrada como weak reference para asegurar la eliminación del resource y evitar referencias 
## inválidas si es que la Entity creada es eliminada.
func set_entity_owner(new_owner: Entity) -> void:
	if new_owner == null:
		properties.owner = null
	else:
		properties.owner = weakref(new_owner)

func _ready() -> void:
	z_index = 3
	ready_hook()

## Identificación para debugging
func _to_string() -> String:
	return "entity"

func ready_hook() -> void:
	pass
