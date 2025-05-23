extends CharacterBody2D

@export var move_speed := Vector2()
var bunny_list:= Array([], TYPE_OBJECT, "Node", DustBunny)


func _process(delta: float) -> void:
	position += move_speed


func add_bunny(bunny : DustBunny) -> void:
	if !bunny_list.has(bunny):
		bunny_list.append(bunny)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bunny"):
		add_bunny(body as DustBunny)
