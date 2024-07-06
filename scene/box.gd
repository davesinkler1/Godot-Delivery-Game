extends RigidBody2D

enum {COINS, BARREL, BOMB, KEY}

@onready var pickup = $PickUp 
var state = "idle"
var player_in_area = false
var lemon = preload("res://scene/lemon_collectable.tscn")
var banana = preload("res://scene/banana_collectable.tscn")
var orange = preload("res://scene/orange_collectable.tscn")
var melon = preload("res://scene/melon_collectable.tscn")

@export var item: InvItem
var player = null

var current_state

func _ready():
	randomize()

func _process(delta):
	
	if state == "drop":
		if player_in_area:
			if Input.is_action_just_pressed("chat"):
				print("interacted")

func choose(array):
	array.shuffle()
	return array.front()


func _on_timer_timeout():
	current_state = choose([COINS, BARREL, BOMB, KEY])
	matchStates()
	#current_state = ""
	#if state == "idle":
		#print("changed state")
		#state = "drop"
		#current_state = choose([LEMON, BANANA, ORANGE, MELON])

func matchStates():
	match current_state:
		COINS:
			#if state == "drop":
			item = load("res://inventory/items/lemons.tres")
			drop_lemon()
			#state = "idle"
		BARREL:
			item = load("res://inventory/items/banana.tres")
			drop_banana()
		BOMB:
			item = load("res://inventory/items/orange.tres")
			drop_orange()
		KEY:
			item = load("res://inventory/items/melon.tres")
			drop_melon()

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		print("body entered")
		player_in_area = true
		player = body


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		player_in_area = false

func drop_lemon():
	var lemon_instance = lemon.instantiate()
	lemon_instance.global_position = $Marker2D.global_position
	get_parent().add_child(lemon_instance)
	player.collect(item)
	pickup.play()

func drop_banana():
	var banana_instance = banana.instantiate()
	banana_instance.global_position = $Marker2D.global_position
	get_parent().add_child(banana_instance)
	player.collect(item)
	pickup.play()

func drop_orange():
	var orange_instance = orange.instantiate()
	orange_instance.global_position = $Marker2D.global_position
	get_parent().add_child(orange_instance)
	player.collect(item)
	pickup.play()

func drop_melon():
	var melon_instance = melon.instantiate()
	melon_instance.global_position = $Marker2D.global_position
	get_parent().add_child(melon_instance)
	player.collect(item)
	pickup.play()
