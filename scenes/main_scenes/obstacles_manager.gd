extends Node2D

@export var tree: PackedScene
@export var desk_looper: DeskLooper

func _ready() -> void:
	desk_looper.wagon_entered.connect(on_wagon_entered)


func on_wagon_entered() -> void:
	for i in randi_range(1,3):
		var t = tree.instantiate()
		call_deferred("add_child", t)
		t.position = desk_looper.position + Vector2(randf_range(0,200), randf_range(0,200))
