extends Panel

var trash_count = 3

func on_trash_disposed():
	trash_count -= 1
	if trash_count == 0:
		get_parent().queue_free()
