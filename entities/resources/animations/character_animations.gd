extends Resource
class_name Animations

var act : Entity

func _init(_act) -> void:
	act = _act

func play_movement() -> AnimatedSprite2D:
	return act.animated_sprites["movement"]

func play_action() -> AnimatedSprite2D:
	return act.animated_sprites["action"]

func play_explotion() -> AnimatedSprite2D:
	return act.animated_sprites["explotion"]
	
