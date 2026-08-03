extends RefCounted
class_name Assertions
	
func assert_movement() -> void:
	if true:
		#print("Todo bien: ", GameManager.current_actor, " se movió.")
		return
	if GameManager.current_actor.properties.can_act and !GameManager.current_actor.properties.is_controllable:
		if ActionQueue.in_process:
			if !GridManager.tween.is_running():
				push_error(GameManager.current_actor, "NPCs deberían estar moviéndose pero permanecen estáticos.")
