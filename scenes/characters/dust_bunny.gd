extends CharacterBody2D

class_name DustBunny

@export var WALK_SPEED: int = 350
@export var target : Node2D = null
@export var facing = "down" # (String, "up", "down", "left", "right")
@export var damage_amount := 2

var anim = ""
var linear_vel := Vector2()
var new_anim = ""

enum { STATE_IDLE, STATE_WALKING, STATE_LATCHED, STATE_ATTACK, STATE_ROLL, STATE_DIE, STATE_HURT }

var state = STATE_IDLE

func _process(delta: float) -> void:
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
		STATE_LATCHED:
			self.reparent(target)
			$LatchDamageTimer.start()
			state = STATE_IDLE


func _on_sightbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("wagon"):
		state = STATE_WALKING
		target = area.owner # this will capture the Wagon's hurtbox and give me the Wagon root node


func _on_latchcircle_area_entered(area: Area2D) -> void:
	if area.is_in_group("wagon"):
		state = STATE_LATCHED


func _on_latch_damage_timer_timeout() -> void:
	target.damage(damage_amount)
