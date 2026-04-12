extends Node
## Controller es un nodo que originalmente debe ser inyectado como nodo hijo en Entities controlables.
## El primer Entity controlable es inyectado desde GameManager._game_set_up()
class_name Controller

var actor : Entity

func _ready() -> void:
	actor = get_parent()
	owner = actor

func set_actor(_act : Entity) -> void:
	actor = _act
