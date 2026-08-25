extends Entity
class_name Bomb

enum { IDLE, IGNITION, EXPLOTION }
var status : int = IDLE

func _to_string() -> String:
	return "bomb"
