extends Node2D

# Load scenes
var pipe_scene = preload("res://scenes/pipe.tscn")
var end_scene = preload("res://scenes/end_screen.tscn")

var move_speed = 100

var space_pressed = false
var doOnce = false

var rng = RandomNumberGenerator.new()

# Score
var score = 0
@onready var score_label = $ScoreLabel

# Counter to keep track of the number of pipes
var pipe_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pipe_scene.is_player_dead
	 
	if Input.is_key_pressed(KEY_SPACE) and !doOnce:
		space_pressed = true
		doOnce = true
		
	
	if space_pressed:
		$Spawn_Timer.start()
		spawn_pipes()
		space_pressed = false

	# Update positions of all pipes
	for i in range(pipe_count):
		var pipe = get_node("Pipe" + str(i + 1))
		if pipe:
			pipe.position.x -= move_speed * delta
		

func spawn_pipes():
	var rng_num = rng.randi_range(1, 3)
	
	if (rng_num == 1.0):
		create_pipe(180, -80)
		create_pipe(180, 60)
	elif (rng_num == 2.0):  
		create_pipe(180, -50)
		create_pipe(180, 90)
	elif (rng_num == 3.0):
		create_pipe(180, -10)
		create_pipe(180, 130)

func create_pipe(x, y):
	# Increment pipe counter
	pipe_count += 1

	# Instantiate the scene
	var new_pipe = pipe_scene.instantiate()

	# Set the name of the new pipe
	new_pipe.name = "Pipe" + str(pipe_count)

	# Set the position of the new pipe
	new_pipe.position = Vector2(x, y)
	
	# Connect signal emitted by the pipe
	new_pipe.connect("player_hit_pipe", _on_player_hit_pipe, 0)
	new_pipe.connect("score_increase", _increase_score, 0)
	
	# Add instance to main game scene
	add_child(new_pipe)
	
func _increase_score():
	score += 1
	score_label.text = str(score)
	
func _on_player_hit_pipe():
	kill_player()

func _on_spawn_timer_timeout():
	spawn_pipes()
	$Spawn_Timer.start()

func _on_killzone_player_died():
	kill_player()
	
func kill_player():
	var gg_screen = end_scene.instantiate()
	add_child(gg_screen)
	
	get_tree().paused = true
