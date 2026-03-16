extends Node

signal start
signal timeout

var timer : float = 2
var command : Command = ActionQueue.current

# Central que itera globalmente el tiempo de cada turno
	# Captura el tiempo que usa cada Command
		# Se debe conectar con un bus de datos para poder calcular modificadores en caso de que exitan
	# Da aviso a TurnManager de cuando el tiempo se acabó y habilite a la siguiente entidad
		# Reinicia el tiempo

func _ready() -> void:
	timeout.connect(TurnManager._on_timeout)
	start.connect(TurnManager._on_start)

func set_command_time_cost(cost : float) -> void:
	if command.is_executing:
		prints("TIEMPO:", timer, "COSTE:", cost)

		await command.finished
		timer -= cost
		time_check()

func _timer_iterator() -> void:
	if timer <= 0:
		timer = 2

	

func time_check() -> void:
	if timer <= 0:
		print("Se acabó el tiempo")
		timeout.emit()
#		await command.finished
		_timer_iterator()
