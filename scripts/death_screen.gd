extends CanvasLayer
# DeathScreen.gd on a CanvasLayer
@onready var overlay = $Overlay  # ColorRect, full screen, black, mouse_filter = IGNORE

func fade_in():
	overlay.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 0.85, 4.0)  # very slow fade, doesn't go full black

func fade_out():
	var tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 0.0, 1.0)
	await tween.finished
	# reset game here
