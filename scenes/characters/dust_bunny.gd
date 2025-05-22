extends CharacterBody2D

@export var WALK_SPEED: int = 350

var linear_vel := Vector2()
var target : Node2D = null
@export var facing = "down" # (String, "up", "down", "left", "right")
var anim = ""
var new_anim = ""

enum { STATE_IDLE, STATE_WALKING, STATE_ATTACK, STATE_ROLL, STATE_DIE, STATE_HURT }

var state = STATE_IDLE

func _process(delta: float) -> void:
	if target != null:
		state = STATE_WALKING
	
	## UPDATE ANIMATION
	if new_anim != anim:
		anim = new_anim
		$anims.play(anim)

func _physics_process(delta: float) -> void:
	match state:
		STATE_IDLE:
			new_anim = "idle"#_ + facing
		STATE_WALKING:
			set_velocity(linear_vel)
			move_and_slide()
			linear_vel = velocity
			var target_speed = Vector2()
			target_speed += (target.position - position).normalized()
			target_speed *= WALK_SPEED
			linear_vel = linear_vel.lerp(target_speed, 0.9)
			if linear_vel != Vector2.ZERO:
				new_anim = "walk"#_ + facing
			else:
				state = STATE_IDLE


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body
