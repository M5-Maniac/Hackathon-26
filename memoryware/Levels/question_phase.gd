extends Node2D

enum phases {quiz, end}
var phase = phases.quiz
var gameTime: float = 20

@onready var game_timer: Timer = $GameTimer
@onready var end_timer: Timer = $EndTimer
@onready var progress_bar: ProgressBar = $Camera2D/ProgressBar
@onready var transition: ColorRect = $Transition
@onready var transition_2: ColorRect = $Transition2


@onready var question_panel: Panel = $CanvasLayer/QuestionPanel
@onready var question_text: Label = $CanvasLayer/QuestionPanel/QuestionText
@onready var answer_a: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerA
@onready var answer_b: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerB
@onready var answer_c: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerC


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_timer.wait_time = gameTime
	game_timer.start()
	game_timer.timeout.connect(time_ran_out)
	end_timer.timeout.connect(transition_over)
	Global.propClicked.connect(prop_clicked)
	Global.lives = 3   # <-- reset lives when start scene loads
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = game_timer.time_left*5
	#transition effect
	match phase:
		0:
			transition.position = transition.position.move_toward(Vector2(484,-186),25)
		1:
			transition_2.position = transition_2.position.move_toward(Vector2(-157,-489),25)



func time_ran_out() -> void:
	print("You lost!")

func transition_over() -> void:
	print("You won!")
	get_tree().change_scene_to_file("res://questions.tscn")

	
func prop_clicked(is_waldo, prop) -> void:
	if is_waldo:
		game_timer.paused = true
		phase = phases.end
		end_timer.start()
		
