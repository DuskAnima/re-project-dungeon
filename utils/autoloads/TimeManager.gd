extends Node

signal timeout

const base_time : float = 2
var timer : float

# Central que itera globalmente el tiempo de cada turno
	# Captura el tiempo que usa cada Command
		# Se debe conectar con un bus de datos para poder calcular modificadores en caso de que exitan
	# Da aviso a TurnManager de cuando el tiempo se acabó y habilite a la siguiente entidad
		# Reinicia el tiempo

func _ready() -> void:
	timer = base_time
	timeout.connect(TurnManager._on_timeout)

func consume_time(cost : float) -> void:
	timer -= cost
	time_check()

func _timer_iterator() -> void:
	if timer <= 0:
		timer = base_time

func time_check() -> void:
	if timer <= 0:
		print("Se acabó el tiempo")
		timeout.emit()
		_timer_iterator()
