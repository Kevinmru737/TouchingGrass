extends Node2D
@onready var interactables = [$Bedroom/Trashcan/Trashcan, $Bedroom/Fishtank/Fishtank, 
	$Bedroom/Bed/Bed, $Bedroom/Musicplayer/Musicplayer, $Bedroom/Bookshelf/Bookshelf]
@onready var bgs = $Bedroom/Background/Happy
func _ready():
	bgs.hide()
	for i in interactables:
		i.add_to_group("interactables")

func show_happy():
	bgs.show()
