extends Control

@onready var turn_list : HBoxContainer = $Panel/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turn_list.add_theme_constant_override("separation", 30)

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
		texture_rect.add_theme_constant_override("margin_left", 20)
		texture_rect.add_theme_constant_override("margin_right", 20)

		turn_list.add_child(texture_rect)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_list()
