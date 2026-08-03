extends Node2D

signal finished_set_up
var assertions : Assertions = Assertions.new()


func _ready() -> void:
	GameManager.entities_node = %Entities
	GameManager.aux_node = %Auxiliar
	finished_set_up.connect(GameManager._on_ready_setup)
	finished_set_up.emit()
	
func _process(_delta: float) -> void:
	assertions.assert_movement()
