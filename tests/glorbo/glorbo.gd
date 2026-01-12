extends Entity

func is_controllable() -> bool:
	return false

func _ready() -> void:
	GameManager.set_current_ai_actor(self)

func _to_string() -> String:
	return "Glorbo"
