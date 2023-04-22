extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75

@onready var pivot = $Pivot

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"): direction.x += 1
	if Input.is_action_pressed("move_left"): direction.x -= 1
	if Input.is_action_pressed("move_back"): direction.z += 1
	if Input.is_action_pressed("move_forward"): direction.z -= 1
	
	if direction == Vector3.ZERO: return
	
	direction = direction.normalized()
	pivot.look_at(position + direction, Vector3.UP)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor(): target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	velocity = target_velocity
	move_and_slide()
