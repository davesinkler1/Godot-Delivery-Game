extends CanvasLayer

@export_file("*.json") var d_file
@onready var rng = RandomNumberGenerator.new()
@onready var dialogue = []
@onready var item = rng.randi_range(0,3)
@onready var current_dialogue_id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.item1.connect(changeitem1)
	SignalManager.item2.connect(changeitem2)
	SignalManager.item3.connect(changeitem3)
	SignalManager.item4.connect(changeitem4)
	start()

func changeitem1():
	item = 0

func changeitem2():
	item = 1

func changeitem3():
	item = 2

func changeitem4():
	item = 3

func start():
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	var file = FileAccess.open("res://dialogue/json/chats.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func next_script():
	#if !item:
		#pass
	current_dialogue_id += item
	if current_dialogue_id >= len(dialogue):
		return
	
	$NinePatchRect/Chat.text = dialogue[current_dialogue_id]['text']


func _on_timer_timeout():
	$Timer.wait_time = 10
	current_dialogue_id = 0
	next_script()
