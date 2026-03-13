extends Node2D

var book_count = 10
signal books_sorted

func on_book_placed():
	book_count -= 1
	if book_count == 0:
		books_sorted.emit()
		self.queue_free()


func _on_book_4_mouse_entered() -> void:
	pass # Replace with function body.


func _on_book_4_mouse_exited() -> void:
	pass # Replace with function body.


func _on_book_5_mouse_entered() -> void:
	pass # Replace with function body.


func _on_book_5_mouse_exited() -> void:
	pass # Replace with function body.


func _on_book_6_mouse_entered() -> void:
	pass # Replace with function body.


func _on_book_6_mouse_exited() -> void:
	pass # Replace with function body.


func _on_book_7_mouse_entered() -> void:
	pass # Replace with function body.


func _on_book_7_mouse_exited() -> void:
	pass # Replace with function body.


func _on_book_8_mouse_entered() -> void:
	pass # Replace with function body.


func _on_book_8_mouse_exited() -> void:
	pass # Replace with function body.


func _on_book_9_mouse_entered() -> void:
	pass # Replace with function body.


func _on_book_9_mouse_exited() -> void:
	pass # Replace with function body.


func _on_book_10_mouse_entered() -> void:
	pass # Replace with function body.


func _on_book_10_mouse_exited() -> void:
	pass # Replace with function body.
