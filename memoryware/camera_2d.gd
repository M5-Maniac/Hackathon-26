extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#slight swaying effect 
	#actually this kinda causes motion sickness and weird pixel effects. might use later but sparingly
	#rotation = delta*sin(Time.get_ticks_msec()/10.0)/1.5
