extends Entity
	
func ready_hook() -> void:
	set_controllable(true)

func _to_string() -> String:
	return "player"
