extends Command
class_name CommandSetBomb

var bomb_scene : PackedScene = preload("uid://bso8g0gkgeipa")

func _init(_act : Entity) -> void:
	act = _act

func execute() -> void:
	var bomb : Bomb = bomb_scene.instantiate() # Instancia la escena de la bomba
	# Establece su posición en base a la posición +  hacia donde está mirando la entidad para instanciarla frente a él
	var bomb_position : Vector2i = act.properties.grid_pos + act.properties.face_direction
	var cast_direction : String =  DIR[act.properties.face_direction]
	var cast_animation : = act.animations.play_action()
	start()

	cast_animation.play("CAST_" + cast_direction)

	var bomb_spawn : Command = CommandSpawn.new(bomb, bomb_position, act)
	ActionQueue.add_wrapped_command(bomb_spawn)
	
	var face_cmd : Command = CommandFace.new(act, act.properties.face_direction)
	
	ActionQueue.add_wrapped_command(face_cmd)
	await cast_animation.animation_finished
	
	finish()

func _set_time_cost() -> float:
	return 0.5
