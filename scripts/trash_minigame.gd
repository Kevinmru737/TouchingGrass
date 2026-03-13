extends Node2D

var trash_count = 5
signal trash_cleaned

func on_trash_disposed():
	trash_count -= 1
	if trash_count == 0:
		trash_cleaned.emit()
		self.queue_free()
		
