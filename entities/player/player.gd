extends Entity

	
func _ready() -> void:
	GameManager.set_current_actor(self)
	set_controllable(true)

func _to_string() -> String:
	return "player"
