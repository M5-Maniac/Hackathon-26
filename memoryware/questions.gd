extends Node2D  # attach this to your main scene root (Node2D)
@onready var question_panel: Panel = $CanvasLayer/QuestionPanel
@onready var question_text: Label = $CanvasLayer/QuestionPanel/QuestionText
@onready var answer_a: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerA
@onready var answer_b: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerB
@onready var answer_c: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerC


# ---- Variables ----
var correct_answer: int = Global.correct_answer
var question: String = Global.question
var correct_answer_index = randi_range(1,3)

# ---- Called when scene starts ----
func _ready() -> void:
	# Hide question panel at start
	question_panel.visible = true
	show_question()
	
	# Connect buttons to root script
	answer_a.pressed.connect(_on_answer_a_pressed)
	answer_b.pressed.connect(_on_answer_b_pressed)
	answer_c.pressed.connect(_on_answer_c_pressed)
	
func _process(_delta: float) -> void:
	pass

# ---- Show question ----
func show_question():
	question_panel.visible = true
	question_text.text = Global.question

	match correct_answer_index:
		1:
			answer_a.text = str(correct_answer)
			answer_b.text = str(int(correct_answer+floor(1+randf()*15*1/Global.difficulty)))
			answer_c.text = str(int(correct_answer+floor(2+randf()*30*1/Global.difficulty)))
		2:
			answer_a.text = str(int(correct_answer+floor(-1-randf()*15*1/Global.difficulty)))
			answer_b.text = str(correct_answer)
			answer_c.text = str(int(correct_answer+floor(1+randf()*15*1/Global.difficulty)))
		3:
			answer_a.text = str(int(correct_answer+floor(-2-randf()*30*1/Global.difficulty)))
			answer_b.text = str(int(correct_answer+floor(-1-randf()*15*1/Global.difficulty)))
			answer_c.text = str(correct_answer)
# ---- Button pressed handlers ----
func _on_answer_a_pressed():
	check_answer(1)

func _on_answer_b_pressed():
	check_answer(2)

func _on_answer_c_pressed():
	check_answer(3)

# ---- Check answer ----
func check_answer(choice):
	if choice == correct_answer_index:
		print("Correct!")
		question_panel.visible = false
		# Move to next level
		get_tree().change_scene_to_file("res://Levels/Level.tscn")
	else:
		print("Wrong!")
		Global.lives -= 1
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://main_menu.tscn")
