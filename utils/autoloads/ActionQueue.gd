extends Node

signal queue_empty

var queue : Array = []
var in_process : bool = false
var current : Command = null
var buffer_command: Command = null  # Buffer para un solo comando de input

## agrega un nuevo comando a la cola. Estos comandos deben ser agregados SOLO por los controles.
func add_command(cmd : Command) -> void:
	if in_process:
		buffer_command = cmd # Buffer: reemplaza el comando pendiente (solo el último)
		print("AQ: BUFFER: ", buffer_command)
	else: # Si no hay comando en proceso
		queue.push_back(cmd) # Agrega un comando al final
		_execute_next() # Ejecutar siguiente

## agrega un nuevo comando a la cola. Estos comandos deben ser agregados SOLO por otros comandos.
func add_wrapped_command(cmd : Command) -> void:
	queue.push_back(cmd) # Agrega un comando al final
	if not in_process : # Si no hay comando en proceso
		_execute_next() # Ejecutar siguiente

func _execute_next() -> void:
	if queue.is_empty(): # Si la lista está vacía
		in_process = false # Flagear que no hay ningun comando en proceso
		queue_empty.emit()
		
		if buffer_command != null: # Si hay comandos en el buffer se ejecuta
			var pending = buffer_command
			buffer_command = null
			add_command(pending)
		
		return # Terminar
		
	if current != null:
		push_error("Existe una recursión en la ejecución del turno, variable 'current' debería ser NULL 
		antes de ejecutar el siguente Command, pero es ", current)

	in_process = true # Flagear que hay un comando en proceso
	current = queue.pop_front() # Sacar el comando de la lista y aislarlo para usarlo
	
	if not current.finished.is_connected(_on_command_finished): # Conectar señal de finalización
		current.finished.connect(_on_command_finished)
		
	current.execute()

func _on_command_finished() -> void:
	CommandBus.command_catcher(current) # Después de que el comando es ejecutado y ya terminó de hacer todos sus calculos
	# internos, el comando es enviado al comand catcher donde se propaga para que sus valores se ejecuten.
	if current and current.finished.is_connected(_on_command_finished):
		current.finished.disconnect(_on_command_finished)
		current = null
	_execute_next()
