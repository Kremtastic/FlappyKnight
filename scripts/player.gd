extends CharacterBody2D

signal has_collided

const SPEED = 130.0
const JUMP_VELOCITY = -150.0

var space_pressed = false;

# Get the gravity from the project settings to be synced with RigidBody nodes.z
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		space_pressed = true;
	
	# Add the gravity.
	if not is_on_floor() and space_pressed:
		velocity.y += gravity * delta * 0.5

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		$Jump.play()

	move_and_slide()


