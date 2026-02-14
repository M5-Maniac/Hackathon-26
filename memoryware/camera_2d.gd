extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#slight swaying effect
	rotation = delta*sin(Time.get_ticks_msec()/500.0)/1.5
