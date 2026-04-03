extends Node

signal timeout

const base_time : float = 2
var act : Entity
# Central que itera globalmente el tiempo de cada turno
	# Captura el tiempo que usa cada Command
		# Se debe conectar con un bus de datos para poder calcular modificadores en caso de que exitan
	# Da aviso a TurnManager de cuando el tiempo se acabó y habilite a la siguiente entidad
		# Reinicia el tiempo

func _ready() -> void:
	timeout.connect(TurnManager._on_timeout)

func consume_time(cost : float) -> void:
	GameManager.current_actor.set_time(cost)
	if GameManager.current_actor.get_time() <= 0:
		print("Se acabó el tiempo")
		timeout.emit()

func timer_reset() -> void:
	print("TIME MANAGER", GameManager.current_actor.get_time())
	print(base_time)
	GameManager.current_actor.set_time(2)
	print("TIME MANAGER", GameManager.current_actor.get_time())
	print(base_time)


	
	
