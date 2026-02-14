extends Node2D
 #classification
enum objects { trash_can, soda_can, tree }
enum colors { red, orange, yellow, green, blue, purple, white, gray, black }
@export var object = objects.trash_can
@export var color = colors.blue

@export var is_waldo: bool = false #is this an object the player is supposed to click?

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
