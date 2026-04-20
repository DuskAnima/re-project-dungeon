extends Command
class_name CommandExplotion

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var cmd : Command = CommandDead.new(act)
	start()
	ActionQueue.add_wrapped_command(cmd)
	var animation : AnimatedSprite2D = act.animations.play_explotion()
	animation.play("EXPLOTION")
	var area_effect : CollisionShape2D = act.get_node("ExplotionArea/ExplotionShape")
	print("area effect Rect: ",area_effect.shape.get_rect().grow(float(GridManager.cell_size)/2))
	#GridManager.set_area_effect(area_effect)
	await animation.animation_finished
	
	finish()

func _set_time_cost() -> float:
	return 1
