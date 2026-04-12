extends Resource
class_name Animations

var act : Entity

func _init(_act) -> void:
	act = _act

func play_movement(_mov : String) -> void:
	act.animated_sprites["movement"].play(_mov)
	
func play_explotion(_status : String) -> void:
	act.animated_sprites["explotion"].play(_status)
