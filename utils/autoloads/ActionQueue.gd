extends Node

var queue : Array = []
var in_process : bool = false
var current : Command = null
var stack = get_stack()

## agrega un nuevo comando a la cola
func add_command(cmd : Command) -> void:
	queue.push_back(cmd) # Agrega un comando al final
	if not in_process : # Si no hay comando en proceso
		_execute_next() # Ejecutar siguiente

func _execute_next() -> void:
	if queue.is_empty(): # Si la lista está vacía
		in_process = false # Flagear que no hay ningun comando en proceso
		return # Terminar
	if current != null:
		push_error("Existe una recursión en la ejecusión del turno, instancia de Command debería ser NULL antes de ejecutar el siguente Command, pero es ", current)
	in_process = true # Flagear que hay un comando en proceso
	current = queue.pop_front() # Sacar el comando de la lista y aislarlo para usarlo
	if not current.finished.is_connected(_on_command_finished): # Conectar señal de finalización
		current.finished.connect(_on_command_finished)
	current.execute() 

func _on_command_finished() -> void:
	if current and current.finished.is_connected(_on_command_finished):
		current.finished.disconnect(_on_command_finished)
		current = null
	_execute_next()

	
func _reset():
	queue.clear()
	in_process = false
	current = null
