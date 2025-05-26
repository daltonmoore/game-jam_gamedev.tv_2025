extends Node2D

class_name Wagon

@export var move_speed_base := 2.0
@export var max_health := 100.0

@onready var health_bar = $HealthBar

var bunny_list:= Array([], TYPE_OBJECT, "Node", DustBunny)
var current_move_speed := 1.0


func _ready() -> void:
	health_bar.init_bar(max_health)


func _physics_process(delta: float) -> void:
	position += Vector2(current_move_speed, 0)
	
	if (bunny_list.size() > 0):
		current_move_speed = move_speed_base - log(bunny_list.size() + 1)
	else:
		current_move_speed = move_speed_base


func add_bunny(bunny : DustBunny) -> void:
	if !bunny_list.has(bunny):
		bunny_list.append(bunny)


func remove_bunny(bunny : DustBunny) -> void:
	if bunny_list.has(bunny):
		bunny_list.erase(bunny)


func damage(amount) -> void:
	health_bar.update_bar(health_bar.health - amount)
	if health_bar.health <= 0:
		get_tree().reload_current_scene()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("bunny"):
		add_bunny(body as DustBunny)


func _on_hurtbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("bunny"):
		remove_bunny(body as DustBunny)
