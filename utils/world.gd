extends Node2D

var assertions : Assertions = Assertions.new()


func _ready() -> void:
	GameManager.entities_node = %Entities
	GameManager.aux_node = %Auxiliar
	GameManager.game_fsm()
	
func _process(_delta: float) -> void:
	assertions.assert_movement()
