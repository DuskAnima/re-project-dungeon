extends Control
class_name TurnPanel

var turn_list : HBoxContainer

func _ready() -> void:
	turn_list = $Panel/HBoxContainer

func update_list() -> void:
	for child in turn_list.get_children():
		child.queue_free()
	
	var entity_list = TurnSystem.turn_order
	
	for turn in entity_list:
		var actor = turn[TurnSystem.ACTOR]
		var sprite = null
		for child in actor.get_children():
			if child is AnimatedSprite2D:
				sprite = child
				break
		if not sprite:
			continue

		var texture = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
		
		var texture_rect = TextureRect.new()
		texture_rect.texture = texture
		texture_rect.expand = true
		texture_rect.size = Vector2(32, 32)
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED

		turn_list.add_child(texture_rect)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_list()
