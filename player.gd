extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal coins_collected
signal barrel_collected
signal bomb_collected
signal key_collected

@export var inv: Inv

@onready var all_interactions = []
@onready var interactLabel = $"Interaction_Components/InteractLabel"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	move_and_slide()
	
	if Input.is_action_just_pressed("chat"):
		execute_interaction()


func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interaction()


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interaction()

func update_interaction():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
		interactLabel.visible = true
	else:
		interactLabel.text = ""

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"print_text" : print(cur_interaction.interact_value)	
			

func player():
	pass

func collect(item):
	inv.insert(item)
	if str(item.name) == "Lemon":
		emit_signal("coins_collected")
	elif str(item.name) == "banana":
		emit_signal("barrel_collected")
	elif str(item.name) == "orange":
		emit_signal("bomb_collected")
	elif str(item.name) == "melon":
		emit_signal("key_collected")


func _on_npc_clearinventory():
	pass # Replace with function body.


func _on_npc_2_clearinventory():
	pass # Replace with function body.


func _on_npc_3_clearinventory():
	pass # Replace with function body.


func _on_npc_4_clearinventory():
	pass # Replace with function body.
