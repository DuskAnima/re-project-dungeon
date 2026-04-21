extends Node

signal timeout

const base_time : float = 2
var act : Entity
# Central que itera globalmente el tiempo de cada turno
	# Captura el tiempo que usa cada Command
		# Se debe conectar con un bus de datos para poder calcular modificadores en caso de que exitan
	# Da aviso a TurnManager de cuando el tiempo se acabó y habilite a la siguiente entidad
		# Reinicia el tiempo

func time_setup(_act: Entity) -> void:
	if _act == null:
		return
	timer_reset(_act)

func consume_time(cost : float) -> void:
	if GameManager.current_actor == null:
		return
	var time_left : float = GameManager.current_actor.get_time()
	GameManager.current_actor.set_time(time_left - cost)
	if GameManager.current_actor.get_time() <= 0:
		timeout.emit()

func timer_reset(_act : Entity) -> void:
	if _act == null:
		return
	_act.set_time(base_time)
