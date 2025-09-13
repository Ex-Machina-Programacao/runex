extends KinematicBody2D

var velocity := Vector2.ZERO

export var jump_height : float = 80
export var jump_time_to_peak : float = 0.5
export var jump_time_to_descent : float = 0.4
export var coyote_time : float = 0.5
export var jump_buffer_time : float = 0.1
export var jump_height_time : float = 0.25

onready var coyote_timer = get_node("TimerCoyote")

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

onready var jump_available : bool = true
onready var jump_buffer : bool = false


func _physics_process(delta):
	#velocity.x += 20 * delta
	
	if not is_on_floor():
		if jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start(coyote_time)
		else:	
			velocity.y += get_gravity() * delta
	else:
		jump_available = true
		coyote_timer.stop()
		if jump_buffer:
			jump()
	
	if Input.is_action_just_pressed("ui_up"):
		if jump_available:
			jump()
		else:
			jump_buffer = true
			get_tree().create_timer(jump_buffer_time).connect("timeout", $".", "on_jump_buffer_timeout")
		
	velocity = move_and_slide(velocity, Vector2.UP)

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	get_tree().create_timer(jump_height_time).connect("timeout", $".", "on_jump_height_timeout")
	velocity.y = jump_velocity
	jump_available = false
	jump_buffer = false

func on_coyote_timer_timeout():
	jump_available = false

func on_jump_buffer_timeout():
	jump_buffer = false
	
func on_jump_height_timeout():
	if not Input.is_action_pressed("ui_up") and velocity.y < 0:
		velocity.y /= 4
