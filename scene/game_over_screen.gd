extends CanvasLayer


func _on_restart_pressed():
	print("button pressed")
	SignalManager.score = 0
	get_tree().change_scene_to_file("res://main.tscn")
	

func _on_quit_pressed():
	get_tree().quit()
