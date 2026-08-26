extends Node

@export var _debug_mode = false

## Al finalizar el Command, envía una referencia de este a CommandProcessor para resolver interacciones.
signal command_completed(cmd: Command)
## Señal emitida cuando no quedan Commands ni en cola ni en buffer.
signal all_commands_finished

var _queue : Array[Command] = []
var _current : Command = null
var _buffer_command: Command = null  # Buffer para un solo comando de input
var _handling_completion : bool = false

## agrega un nuevo comando a la cola. Estos comandos deben ser agregados SOLO por los controles.
func add_command(cmd : Command) -> void:
	if _current != null:
		_buffer_command = cmd # Buffer: reemplaza el comando pendiente (solo el último)
		if _debug_mode:
			prints("AQ: BUFFER:", cmd.act, _buffer_command)
	else: # Si no hay comando en proceso
		if _debug_mode:
			print(cmd.act ," está encolando: ", cmd)
		_enqueue(cmd) # Agrega un comando al final

## agrega un nuevo comando a la cola. Estos comandos deben ser agregados SOLO por otros comandos, no aplica buffer.
func add_wrapped_command(cmd : Command) -> void:
	_enqueue(cmd)

func _enqueue(cmd : Command) -> void:
	_queue.push_back(cmd)
	if _debug_mode:
		print("queue: ", _queue)
	if _current == null and not _handling_completion:
		_execute_next()

func _execute_next() -> void:
	if _current != null:
		if _debug_mode:
			push_error("Action Queue: se intentó ejecutar otro Command mientras había otro en curso.")
		return
	if _queue.is_empty(): # Si la lista está vacía
		if _buffer_command != null and _buffer_command.act.get_time() > 0: # Si hay comandos en el buffer se ejecuta
			var pending = _buffer_command
			_buffer_command = null
			_enqueue(pending)
			return
		else:
			_buffer_command = null
			all_commands_finished.emit()
			return # Terminar
	_current = _queue.pop_front()
	if _debug_mode:
		print(_current.act, " está ejecutando: ", _current, ". tiempo restante: ", _current.act.get_time())
	_current.finished.connect(_on_command_finished, CONNECT_ONE_SHOT)
	_current.execute()


func _on_command_finished() -> void:
	if _current == null:
		return
	var completed_cmd = _current
	_current = null
	_handling_completion = true
	command_completed.emit(completed_cmd)
	_handling_completion = false
	_execute_next()
