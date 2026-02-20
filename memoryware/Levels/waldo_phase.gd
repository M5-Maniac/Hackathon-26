extends Node2D

enum phases {game, end}
var phase = phases.game

@onready var game_timer: Timer = $GameTimer
@onready var end_timer: Timer = $EndTimer
@onready var progress_bar: ProgressBar = $Camera2D/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_timer.start()
	game_timer.timeout.connect(time_ran_out)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = game_timer.time_left*5
	
func time_ran_out(delta: float) -> void:
	print("You lost!")
