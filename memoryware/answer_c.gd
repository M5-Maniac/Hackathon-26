extends Node2D  # or Control if you attach to QuestionPanel

# ---- Variables ----
var correct_answer = "A"

# ---- Called when scene starts ----
func _ready() -> void:
	# Make sure the question panel is hidden at start
	$CanvasLayer/QuestionPanel.visible = false
	
	# Connect buttons (if you haven't connected in editor)
	$CanvasLayer/QuestionPanel/AnswerA.pressed.connect(_on_answer_a_pressed)
	$CanvasLayer/QuestionPanel/AnswerB.pressed.connect(_on_answer_b_pressed)
	$CanvasLayer/QuestionPanel/AnswerC.pressed.connect(_on_answer_c_pressed)
	
# ---- Show question ----
func show_question():
	$CanvasLayer/QuestionPanel.visible = true
	$CanvasLayer/QuestionPanel/QuestionText.text = "What color was the Tree?"
	$CanvasLayer/QuestionPanel/AnswerA.text = "Orange"
	$CanvasLayer/QuestionPanel/AnswerB.text = "Dark Orange"
	$CanvasLayer/QuestionPanel/AnswerC.text = "Bronze"
	
	correct_answer = "A"  # set the correct answer

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
		# call next level function here if you have one
	else:
		print("Wrong!")
		Global.lives -= 1
		print("Lives left:", Global.lives)
		
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://GameOver.tscn")
