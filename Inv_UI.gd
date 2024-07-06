extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	SignalManager.update.connect(update_slots)
	SignalManager.remove.connect(remove_slots)
	#update_slots()
	visible = true
	is_open = true

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func remove_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].remove(inv.slots[i])
