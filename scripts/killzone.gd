extends Area2D

var end_screen = preload("res://scenes/end_screen.tscn")

signal player_died

func _on_body_entered(body):
	#print("You died! (killzone)")
	emit_signal("player_died")
