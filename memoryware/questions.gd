extends Node2D  # attach this to your main scene root (Node2D)
@onready var question_panel: Panel = $CanvasLayer/QuestionPanel
@onready var question_text: Label = $CanvasLayer/QuestionPanel/QuestionText
@onready var answer_a: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerA
@onready var answer_b: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerB
@onready var answer_c: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerC

# ---- Variables ----
var correct_answer = "A"

# ---- Called when scene starts ----
func _ready() -> void:
	# Hide question panel at start
	question_panel.visible = false
	
	# Connect buttons to root script
	answer_a.pressed.connect(_on_answer_a_pressed)
	answer_b.pressed.connect(_on_answer_b_pressed)
	answer_c.pressed.connect(_on_answer_c_pressed)
	
func _process(_delta: float) -> void:
	pass

# ---- Show question ----
func show_question():
	$CanvasLayer/QuestionPanel.visible = true
	$CanvasLayer/QuestionPanel/QuestionText.text = "What color was the Tree?"
	$CanvasLayer/QuestionPanel/AnswerA.text = "orange"
	$CanvasLayer/QuestionPanel/AnswerB.text = "Bronze"
	$CanvasLayer/QuestionPanel/AnswerC.text = "Dark Orange"
	
	question_panel.visible = true
	question_text.text = "How many balloons were there?"
	answer_a.text = "2"
	answer_b.text = "4"
	answer_c.text = "6"
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
		question_panel.visible = false
		# Move to next level
		get_tree().change_scene_to_file("res://Scenes/Level1.tscn")
	else:
		print("Wrong!")
		Global.lives -= 1
		print("Lives left:", Global.lives)
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://GameOver.tscn")
