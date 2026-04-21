extends Resource
class_name Animations

signal animation_changed

var act : Entity
var animations : Dictionary
var current_animation : String

func _init(_act) -> void:
	animation_changed.connect(_on_animation_changed)
	act = _act

func play_movement() -> AnimatedSprite2D:
	current_animation = "movement"
	animation_changed.emit()
	act.animated_sprites["movement"].visible = true
	return act.animated_sprites["movement"]

func play_action() -> AnimatedSprite2D:
	current_animation = "action"
	animation_changed.emit()
	act.animated_sprites["action"].visible = true
	return act.animated_sprites["action"]

func play_explotion() -> AnimatedSprite2D:
	return act.animated_sprites["explotion"]

func _on_animation_changed() -> void:
	animations = act.animated_sprites
	for animation in animations:
		if animation != current_animation:
			act.animated_sprites[animation].visible = false
