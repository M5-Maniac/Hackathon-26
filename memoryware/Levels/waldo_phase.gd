extends Node2D
 
enum phases {game, end}
var phase = phases.game
var gameTime: float = clamp(20-Global.difficulty/2,5,100)
var won: bool = false

@onready var game_timer: Timer = $GameTimer
@onready var end_timer: Timer = $EndTimer
@onready var progress_bar: ProgressBar = $Camera2D/ProgressBar
@onready var transition: ColorRect = $Transition
@onready var transition_2: ColorRect = $Transition2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_timer.wait_time = gameTime
	game_timer.start()
	game_timer.timeout.connect(time_ran_out)
	end_timer.timeout.connect(transition_over)
	Global.propClicked.connect(prop_clicked)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = game_timer.time_left*5
	progress_bar.value = game_timer.time_left*(100/gameTime)
	#transition effect
	match phase:
		0:
			transition.position = transition.position.move_toward(Vector2(484,-186),25)
		1:
			transition_2.position = transition_2.position.move_toward(Vector2(-157,-489),25)

func time_ran_out() -> void:
	if !won:
		game_timer.paused = true
		phase = phases.end
		Global.lives -= 1
		end_timer.start()
	
func transition_over() -> void:
	if won:
		print("You won!")
		get_tree().change_scene_to_file("res://Levels/Level.tscn")
	elif Global.lives > 0:
		print("You lost a life!")
		get_tree().change_scene_to_file("res://Levels/Level.tscn")
	else:
		print("You lost!")
		get_tree().change_scene_to_file("res://main_menu.tscn")
		
		
func prop_clicked(is_waldo, prop) -> void:
	if is_waldo and !game_timer.paused:
		game_timer.paused = true
		won = true
		phase = phases.end
		Global.difficulty += 1
		end_timer.start()
		
		
