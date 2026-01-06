extends Entity

var actor : StringName = "Player"

func is_controllable() -> bool:
	return true

func _ready() -> void:
	GameManager.set_current_actor(self)
