extends Node

var queue : Array = []
var in_process : bool = false
var current : Command = null
var stack = get_stack()

## agrega un nuevo comando a la cola
func add_command(cmd : Command) -> void:
#	prints("AÑADIENDO comando:", cmd, "id:", cmd.get_instance_id(), "desde:", stack)
	queue.push_back(cmd) # Agrega un comando al final
	prints("lista de comandos", queue)
	if not in_process : # Si no hay comando en proceso
		_execute_next() # Ejecutar siguiente

func _execute_next() -> void:
	prints("<<<<<EXECUTE NEXT>>>>>>")
	if queue.is_empty(): # Si la lista está vacía
		in_process = false # Flagear que no hay ningun comando en proceso
		prints("No Queue, stoping (esperando notifiación post command.execute())")
		return # Terminar
	
	in_process = true # Flagear que hay un comando en proceso
	prints("Pre asignación de comando", current)
	current = queue.pop_front() # Sacar el comando de la lista y aislarlo para usarlo
	prints("Post asignación de comando", current)

	if not current.finished.is_connected(_on_command_finished): # Conectar señal de finalización
		current.finished.connect(_on_command_finished)
	prints("pre command.execute() : ", current)
	current.execute() 
	prints("post command.execute() : ", current, "<- post _on_command_finished, tiene que ser null. FINALIZACIÓN")


func _on_command_finished() -> void:
	var finished = []
	if current and current.finished.is_connected(_on_command_finished):
		current.finished.disconnect(_on_command_finished)
		prints("on_command_finished_ pre execute_next()", current, "Eliminando comando, verificación de next in Queue")
		finished.append(current)
		current = null
		
	_execute_next()
	print("_on_command_finished_ post execute_next()", current, " <- Comando eliminado, debería ser null en el útlimo")
	prints("Comandos ejecutados: ", finished)
func _reset():
	queue.clear()
	in_process = false
	current = null
