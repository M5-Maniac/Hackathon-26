extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var prop_count = get_child_count()
	var waldo_prop = randi_range(0,prop_count-1)
	get_child(waldo_prop).is_waldo = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
