extends Node2D

var book_count = 10
signal books_sorted

func on_book_placed():
	book_count -= 1
	if book_count == 0:
		books_sorted.emit()
		self.queue_free()
