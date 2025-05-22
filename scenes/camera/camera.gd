extends Camera2D

@export var move_speed := Vector2()

func _process(delta: float) -> void:
	position += move_speed
