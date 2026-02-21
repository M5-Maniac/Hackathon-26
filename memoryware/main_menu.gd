extends Control

@onready var play_button: Button = $MarginContainer/PlayButton
@onready var transition: ColorRect = $Transition
@onready var transition_timer: Timer = $TransitionTimer
@onready var score: RichTextLabel = $Score

var transitioning: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if transitioning:
		transition.position = transition.position.move_toward(Vector2(-147,-362),25)
	score.text = "Last score: " + str(Global.score)

	


func _on_button_pressed() -> void: #main menu button
	play_button.disabled = true
	transitioning = true
	transition_timer.start()




func _on_transition_timer_timeout() -> void:
	#get_tree().change_scene_to_file("res://Levels/Level.tscn")
	Global.difficulty = 1
	Global.lives = 3
	Global.score = 0
	Global.switchToLevel.emit()
