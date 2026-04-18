extends Node
## Controller es un nodo que originalmente debe ser inyectado como nodo hijo en Entities controlables.
## El primer Entity controlable es inyectado desde GameManager._game_set_up()
class_name Controller

var actor : Entity

func _ready() -> void:
	name = get_script().get_global_name()
	actor = get_parent() # Obtiene al actor que instancia el control.
	owner = actor # Lo establece como dueño del nodo.

## Iyecta al actor desde GameManager
func set_actor(_act : Entity) -> void:
	actor = _act

## Función que sirve como un pack de checks que permiten a las entidades tomar su turno. Debe usarse previo a
## La función que genere los inputs.
func _player_action_check() -> bool:
	if actor == null: return false
	if actor.properties.is_controllable == false: return false
	if actor.properties.can_act == false: return false
	else: return true

func _npc_action_check() -> bool:
	if actor == null: return false
	if ActionQueue.in_process == true: return false
	if actor == null: return false
	if actor.properties.can_act == false: return false
	else: return true
