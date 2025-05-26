extends Node2D

@export var desk_looper: DeskLooper
@export var bunny_scene:= preload("res://scenes/characters/dust_bunny.tscn")
@export var bunnies: Node2D

func _ready() -> void:
	desk_looper.wagon_entered.connect(on_wagon_entered)



func on_wagon_entered() -> void:
	var rand_spawn_amount = randi_range(1,13)
	for i in rand_spawn_amount:
		print(i)
		var bunny = bunny_scene.instantiate()
		bunnies.call_deferred("add_child", bunny)
		bunny.position = desk_looper.position + Vector2(randf_range(0,500), randf_range(0,100))
		position =  desk_looper.position
