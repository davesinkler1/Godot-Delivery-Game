extends Node
@onready var timer = $Timer
@onready var seconds = $Seconds

const GameOverScreen = preload("res://scene/game_over_screen.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	seconds.text = str(int(timer.time_left))


func _on_timer_timeout():
	#var game_over = GameOverScreen.instance()
	#add_child(game_over)
	get_tree().change_scene_to_file("res://scene/game_over_screen.tscn")
	
