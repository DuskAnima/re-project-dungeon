extends Node

var queue : Array = []
var is_executing : bool = false
var current : Command = null

func add_command(cmd : Command) -> void:
	queue.push_back(cmd)
	if not is_executing:
		_execute_next()

func _execute_next() -> void:
	if queue.is_empty():
		is_executing = false
		return

	is_executing = true
	current = queue.pop_front()

	if not current.finished.is_connected(_on_command_finished):
		current.finished.connect(_on_command_finished)
	current.execute()

func _on_command_finished() -> void:
	if current and current.finished.is_connected(_on_command_finished):
		current.finished.disconnect(_on_command_finished)
		current = null
	_execute_next()

func _reset():
	queue.clear()
	is_executing = false
	current = null
