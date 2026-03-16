@abstract
extends RefCounted
class_name Command

signal started
signal finished

var time_cost : float = _set_time_cost()
var is_executing : bool = false
# Identificador único para depuración
var _debug_id: int = randi_range(0, 1000)

@abstract
## Función de inicialización de comandos. Cada comando tiene diferentes requerimientos que deben ser implementados
## y documentados individualmente.
func _init() -> void

## La ejecución debe ser implementada. Siempre debe llamarse start() al comienzo de la implementación y finish() al
## final
@abstract
func execute() -> void

## Es necesario declarar el coste de tiempo con un return de un float
@abstract
func _set_time_cost() -> float

## Conecta a CommandBus
func start() -> void:
	started.connect(CommandBus.on_command_start, CONNECT_ONE_SHOT)
	is_executing = true
	started.emit(time_cost)

## Envía información pertinente a ActionQueue
func finish() -> void:
#	finished.connect(CommandBus.on_command_finished, CONNECT_ONE_SHOT)
	print("EMITIENDO AVISO DE QUE EL COMANDO TERMINÓ")
	is_executing = false
	finished.emit()

func _to_string() -> String:
	return "%s(id=%d)" % [get_script().get_global_name(), _debug_id]
