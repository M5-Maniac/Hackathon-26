extends Node2D  # attach this to your main scene root (Node2D)
@onready var question_panel: Panel = $CanvasLayer/QuestionPanel
@onready var question_text: Label = $CanvasLayer/QuestionPanel/QuestionText
@onready var answer_a: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerA
@onready var answer_b: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerB
@onready var answer_c: Button = $CanvasLayer/QuestionPanel/QuestionText/AnswerC

@onready var transition: ColorRect = $CanvasLayer/Transition
@onready var transition_2: ColorRect = $CanvasLayer/Transition2
@onready var end_timer: Timer = $EndTimer

enum phases {game, end}
var phase = phases.game
# ---- Variables ----
var correct_answer: int = Global.correct_answer
var question: String = Global.question

var correct_answer_index
# ---- Called when scene starts ----
func _ready() -> void:
	if correct_answer in range(0,2):
		correct_answer_index = 1
	elif correct_answer in range(2,4):
		correct_answer_index = randi_range(1,2)
	else:
		correct_answer_index = randi_range(1,3)

	show_question()
	
	# Connect buttons to root script
	answer_a.pressed.connect(_on_answer_a_pressed)
	answer_b.pressed.connect(_on_answer_b_pressed)
	answer_c.pressed.connect(_on_answer_c_pressed)
	
func _process(_delta: float) -> void:
	match phase:
		0:
			transition.position = transition.position.move_toward(Vector2(484,-186),25)
		1:
			transition_2.position = transition_2.position.move_toward(Vector2(-157,-489),25)


# ---- Show question ----
func show_question():
	question_panel.visible = true
	question_text.text = Global.question
	
	var randomAddition: int = randi_range(0,1+floor(5/Global.difficulty))
	match correct_answer_index:
		#1:
			#answer_a.text = str(correct_answer)
			#answer_b.text = str(int(correct_answer+floor(1+(10+randi_range(0,10))/Global.difficulty)))
			#answer_c.text = str(int(correct_answer+floor(2+randf()*30*1/Global.difficulty)))
		#2:
			#answer_a.text = str(int(correct_answer+floor(-1-randf()*15*1/Global.difficulty)))
			#answer_b.text = str(correct_answer)
			#answer_c.text = str(int(correct_answer+floor(1+randf()*15*1/Global.difficulty)))
		#3:
			#answer_a.text = str(int(correct_answer+floor(-2-randf()*30*1/Global.difficulty)))
			#answer_b.text = str(int(correct_answer+floor(-1-(10+randi_range(0,10))/Global.difficulty)))
			#answer_c.text = str(correct_answer)
		1:
			answer_a.text = str(correct_answer)
			answer_b.text = str(int(correct_answer+1+randi_range(0,randomAddition)))
			answer_c.text = str(int(correct_answer+2+randi_range(randomAddition,randomAddition*2)))
		2:
			answer_a.text = str(clamp(int(correct_answer-1-randi_range(0,randomAddition)),0,200))
			answer_b.text = str(correct_answer)
			answer_c.text = str(int(correct_answer+1+randi_range(0,randomAddition)))
		3:
			answer_a.text = str(clamp(int(correct_answer-2-randi_range(randomAddition,randomAddition*2)),0,200))
			answer_b.text = str(clamp(int(correct_answer-1-randi_range(0,randomAddition)),0,200))
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
		Global.score += 1
		question_panel.visible = false
		# Move to next level
		phase = phases.end
		answer_a.queue_free()
		answer_b.queue_free()
		answer_c.queue_free()
		end_timer.start()
	else:
		print("Wrong!")
		Global.lives -= 1
		if Global.lives <= 0:
			Global.switchToMain.emit()
		else:
			phase = phases.end
			answer_a.queue_free()
			answer_b.queue_free()
			answer_c.queue_free()
			end_timer.start()


func _on_end_timer_timeout() -> void:
		Global.switchToLevel.emit()
