extends Resource

class_name Inv

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !emptyslots.is_empty():
		emptyslots[0].item = item
	SignalManager.update.emit()

func remove(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].item = null
	SignalManager.remove.emit()
