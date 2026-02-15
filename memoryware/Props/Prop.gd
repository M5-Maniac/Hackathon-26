extends Node2D
 #classification
enum objects { trash_can, backpack, tree }
enum colors { red, orange, yellow, green, blue, purple, white, gray, black }
@export var object = objects.trash_can
@export var color = colors.blue

@export var is_waldo: bool = false #is this an object the player is supposed to click?

var prop_hitbox
var prop_sprite
var hovered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Finds hitbox in the prop, sets it to a variable. probably an inefficient way of doing this but oh well
	for child in get_children():
		if child.name == "Hitbox":
			prop_hitbox = child
		if child.name == "Sprite":
			prop_sprite = child
			
	
	prop_hitbox.mouse_entered.connect(mouse_entered_hitbox)
	prop_hitbox.mouse_exited.connect(mouse_exited_hitbox)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if hovered:
		get_viewport().set_input_as_handled()
		scale = scale.move_toward(Vector2(1.1,1.1),0.025)
	else:
		scale = scale.move_toward(Vector2(1,1),0.034)
	
func mouse_entered_hitbox() -> void:
	hovered = true
	
func mouse_exited_hitbox() -> void:
	hovered = false
