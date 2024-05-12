extends Button


func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_pressed()

func _on_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
