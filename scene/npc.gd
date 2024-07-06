extends CharacterBody2D

enum {COINS, BARREL, BOMB, KEY}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_state
var is_chatting = false
var player
var player_in_chat_zone = false
var coins = 0
var barrel = 0
var bomb = 0
var key = 0
@onready var dropoff = $DropOff

signal clearinventory

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func _ready():
	randomize()

func _process(delta):
	var choice
	
	match current_state:
		COINS:
			choice = 0
			SignalManager.item1.emit()
			#print("LEMON")
		BARREL:
			choice = 1
			SignalManager.item2.emit()
			#print("BANANA")
		BOMB:
			choice = 2
			SignalManager.item3.emit()
			#print("ORANGE")
		KEY:
			choice = 3
			SignalManager.item4.emit()
			#print("MELON")

func choose(array):
	array.shuffle()
	return array.front()


func _on_timer_timeout():
	$Timer.wait_time = 10
	current_state = choose([COINS, BARREL, BOMB, KEY])


func _on_chat_detection_area_body_entered(body):
	#if body.has_method("player"):
	player = body
	player_in_chat_zone = true
	is_chatting = true
	if coins >= 1 && current_state == COINS:
		SignalManager.score += 1
		dropoff.play()
		emit_signal("clearinventory")
	elif barrel >= 1 && current_state == BARREL:
		SignalManager.score += 1
		dropoff.play()
		emit_signal("clearinventory")
	elif bomb >= 1 && current_state == BOMB:
		SignalManager.score += 1
		dropoff.play()
		emit_signal("clearinventory")
	elif key >= 1 && current_state == KEY:
		SignalManager.score += 1
		dropoff.play()
		emit_signal("clearinventory")


func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false


func _on_player_coins_collected():
	coins += 1
	


func _on_player_key_collected():
	key += 1


func _on_player_bomb_collected():
	bomb += 1


func _on_player_barrel_collected():
	barrel += 1
