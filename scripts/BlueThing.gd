extends KinematicBody2D

enum {
	IDLE,
	WANDER
}

var velocity = Vector2.ZERO
var state = IDLE

const ACCELERATION = 300
const MAX_SPEED = 50
const TOLERANCE = 4.0

onready var start_position = global_position
onready var target_position = global_position

func update_target_position():
	var target_vector = Vector2(rand_range(-300, 300), rand_range(-32, 32))
	target_position = start_position + target_vector

func is_at_target_position(): 
	# Stop moving when at target +/- tolerance
	return (target_position - global_position).length() < TOLERANCE

func _physics_process(delta):
	match state:
		IDLE:
			state = WANDER
			# Maybe wait for X seconds with a timer before moving on
			update_target_position()

		WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)

			if is_at_target_position():
				state = IDLE

	velocity = move_and_slide(velocity)

func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - global_position).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	velocity += acceleration_vector
	velocity = velocity.clamped(MAX_SPEED)
