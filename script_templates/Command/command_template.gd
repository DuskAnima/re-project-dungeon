# meta-name: Command 
# meta-description: Predefinición básica de todos los Commands.
extends Command

func _init(_act : Entity) -> void:
## Función de inicialización de comandos. Cada comando tiene diferentes requerimientos que deben ser implementados
## y documentados individualmente.
	act = _act

func execute() -> void:
## La ejecución debe ser implementada. Siempre debe llamarse start() al comienzo de la implementación y finish() al
## final
	pass

func _set_time_cost() -> float:
	return 0
## Es necesario declarar el coste de tiempo con un return de un float.
