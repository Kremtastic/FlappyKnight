extends Area2D

signal player_hit_pipe
signal score_increase

# Destroy pipe when exit screen
func _on_visible_on_screen_notifier_2d_screen_exited(): # Lags the game a lot, disabled for now.
	#print("Pipe destroyed!")
	#queue_free()
	pass

# Player hits pipe
func _on_body_entered(body):
	emit_signal("player_hit_pipe")
	$ScoreCountArea/HitSound.play()
func _on_score_count_area_body_entered(body):
	emit_signal("score_increase")
	$ScoreCountArea/PickupSound.play()
