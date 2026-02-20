extends Node2D  # attach this to your main scene root (Node2D)

# ---- Variables ----
var correct_answer = "A"

# ---- Called when scene starts ----
func _ready() -> void:
	# Hide question panel at start
	$CanvasLayer/QuestionPanel.visible = false
	
	# Connect buttons to root script
	$CanvasLayer/QuestionPanel/AnswerA.pressed.connect(_on_answer_a_pressed)
	$CanvasLayer/QuestionPanel/AnswerB.pressed.connect(_on_answer_b_pressed)
	$CanvasLayer/QuestionPanel/AnswerC.pressed.connect(_on_answer_c_pressed)
	
	# Reset lives
	Global.lives = 3
	
	# If you already have your timers or other setup, keep them here
	# Example from your start scene:
	# game_timer.start()
	# game_timer.timeout.connect(time_ran_out)
	# end_timer.timeout.connect(transition_over)
	# Global.propClicked.connect(prop_clicked)

# ---- Show question ----
func show_question():
	$CanvasLayer/QuestionPanel.visible = true
	$CanvasLayer/QuestionPanel/QuestionText.text = "What color was the Tree?"
	$CanvasLayer/QuestionPanel/AnswerA.text = "orange"
	$CanvasLayer/QuestionPanel/AnswerB.text = "Bronze"
	$CanvasLayer/QuestionPanel/AnswerC.text = "An mix of both"
	
	correct_answer = "B"

# ---- Button pressed handlers ----
func _on_answer_a_pressed():
	check_answer("A")

func _on_answer_b_pressed():
	check_answer("B")

func _on_answer_c_pressed():
	check_answer("C")

# ---- Check answer ----
func check_answer(choice):
	if choice == correct_answer:
		print("Correct!")
		$CanvasLayer/QuestionPanel.visible = false
		# Move to next level
		get_tree().change_scene_to_file("res://Levels/Level.tscn")
	else:
		print("Wrong!")
		Global.lives -= 1
		print("Lives left:", Global.lives)
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://GameOver.tscn")
