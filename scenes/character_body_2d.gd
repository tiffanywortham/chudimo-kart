extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -600.0

func _physics_process(delta: float) -> void:
	velocity.x = 400
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5

	move_and_slide()
