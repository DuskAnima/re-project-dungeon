extends Resource
class_name Animations

signal animation_changed

## Entidad enlazada al recurso, cada entidad crea su propio recurso.
var act : Entity
## Referencia a act.animated_sprites que contiene [String(Nombre de tipo de animación), 
## AnimatedSprite2D(Nodo con respectivas animaciones)]
var animations : Dictionary 
## Nombre de la animación en curso
var current_animation : String

## El recurso recibe self del actor para conectar la señal y recibir una referencia del dueño de las animaciones.
func _init(_act) -> void:
	animation_changed.connect(_on_animation_changed)
	act = _act

## Función que recibe una constante de dirección para detonar animación de una entity mirando hacia una dirección concreta 
func face_to_animation(dir: Vector2i) -> void:
	var sprite : AnimatedSprite2D = _play_movement()
	var animation_name : String
	match dir:
		Vector2i.UP: animation_name = "FACE_UP"
		Vector2i.DOWN: animation_name = "FACE_DOWN"
		Vector2i.LEFT: animation_name = "FACE_LEFT"
		Vector2i.RIGHT: animation_name = "FACE_RIGHT"
		_: animation_name = "FACE_DOWN"
	sprite.play(animation_name)

func move_to_animation(dir: Vector2i) -> void:
	var sprite: AnimatedSprite2D = _play_movement()
	var animation_name : String
	match dir:
		Vector2i.UP: animation_name = "MOVE_UP"
		Vector2i.DOWN: animation_name = "MOVE_DOWN"
		Vector2i.LEFT: animation_name = "MOVE_LEFT"
		Vector2i.RIGHT: animation_name = "MOVE_RIGHT"
		_: animation_name = "MOVE_DOWN"
	sprite.play(animation_name)

func _play_movement() -> AnimatedSprite2D:
	current_animation = "movement"
	animation_changed.emit()
	act.animated_sprites["movement"].visible = true
	return act.animated_sprites["movement"]

func play_action() -> AnimatedSprite2D:
	current_animation = "action"
	animation_changed.emit()
	act.animated_sprites["action"].visible = true
	return act.animated_sprites["action"]

func play_explotion() -> AnimatedSprite2D:
	return act.animated_sprites["explotion"]

func _on_animation_changed() -> void:
	animations = act.animated_sprites
	for animation in animations:
		if animation != current_animation:
			act.animated_sprites[animation].visible = false
