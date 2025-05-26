extends Area2D

class_name DeskLooper

signal wagon_entered

@export var desk_tiles : TileMapLayer
@export var loop_dist := 0.0


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("wagon"):
		desk_tiles.position.x = position.x
		position.x += loop_dist
		wagon_entered.emit()
