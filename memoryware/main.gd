extends Node2D
const MAIN_MENU = preload("res://main_menu.tscn")
const LEVEL = preload("res://Levels/Level.tscn")
const QUESTIONS = preload("res://questions.tscn")

@onready var menu_music: AudioStreamPlayer2D = $MenuMusic
@onready var game_music: AudioStreamPlayer2D = $GameMusic


@onready var visual: Node2D = $Visual

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
	pass

func switch_to_level():
	menu_music.stop()
	if !game_music.playing:
		game_music.play()
		
	for child in visual.get_children():
		print(child)
		child.queue_free()
	level = LEVEL.instantiate()
	visual.add_child(level)

func switch_to_question():
	print("who")
	for child in visual.get_children():
		child.queue_free()
	questions = QUESTIONS.instantiate()
	visual.add_child(questions)
	
func switch_to_main():
	print("hi")
	game_music.stop()
	menu_music.play()
	for child in visual.get_children():
		child.queue_free()
	main = MAIN_MENU.instantiate()
	visual.add_child(main)
