extends Node2D

func _on_FallZone_body_entered(body):
	get_tree().reload_current_scene()
