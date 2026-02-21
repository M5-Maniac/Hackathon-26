extends Node2D
const MAIN_MENU = preload("res://main_menu.tscn")
const LEVEL = preload("res://Levels/Level.tscn")
const QUESTIONS = preload("res://questions.tscn")
const LEVEL_2 = preload("res://Levels/Level2.tscn")

@onready var menu_music: AudioStreamPlayer2D = $MenuMusic
@onready var game_music: AudioStreamPlayer2D = $GameMusic
@onready var quiz_music: AudioStreamPlayer2D = $QuizMusic
@onready var quiz_sfx: AudioStreamPlayer2D = $QuizSfx

@onready var visual: Node2D = $Visual

@onready var life_display: RichTextLabel = $LifeDisplay
@onready var score_display: RichTextLabel = $ScoreDisplay

var main
var level
var questions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_music.play()
	visual.add_child(MAIN_MENU.instantiate())
	Global.switchToLevel.connect(switch_to_level)
	Global.switchToMain.connect(switch_to_main)
	Global.switchToQuestion.connect(switch_to_question)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	life_display.text = "LIVES: " + str(Global.lives)
	life_display.position = Vector2(-240.0,-135) + Global.cameraPosition
	score_display.text = "SCORE: " + str(Global.score)
	score_display.position = Vector2(166.0,-135) + Global.cameraPosition
func switch_to_level():
	menu_music.stop()
	quiz_music.stop()
	if !game_music.playing:
		game_music.play()
		
	for child in visual.get_children():
		print(child)
		child.queue_free()
	if randf() <0.5:
		level = LEVEL.instantiate()
		visual.add_child(level)
	else:
		level = LEVEL_2.instantiate()
		visual.add_child(level)
	
func switch_to_question():
	print("who")
	quiz_sfx.play()
	game_music.stop()
	await get_tree().create_timer(1.0).timeout
	quiz_music.play()
	quiz_sfx.stop()
	
	
	for child in visual.get_children():
		child.queue_free()
	questions = QUESTIONS.instantiate()
	visual.add_child(questions)
	
func switch_to_main():
	print("hi")
	game_music.stop()
	quiz_music.stop()
	menu_music.play()
	for child in visual.get_children():
		child.queue_free()
	main = MAIN_MENU.instantiate()
	visual.add_child(main)
