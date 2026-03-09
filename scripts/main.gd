extends Node2D
@onready var interactables = [$Bedroom/Trashcan/Trashcan, $Bedroom/Fishtank/Fishtank, 
	$Bedroom/Bed/Bed, $Bedroom/Musicplayer/Musicplayer, $Bedroom/Bookshelf/Bookshelf]

func _ready():
	for i in interactables:
		i.add_to_group("interactables")
