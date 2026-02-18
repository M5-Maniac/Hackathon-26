@tool
extends Node2D
 #classification
enum objects { trash_can, backpack, tree }
enum colors { red, orange, yellow, green, blue, purple, white, gray, black }
@export var object = objects.trash_can
@export var color = colors.blue
@export var flip_h: bool = false
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
			if flip_h:
				child.flip_h = true
		
	
	prop_hitbox.mouse_entered.connect(mouse_entered_hitbox)
	prop_hitbox.mouse_exited.connect(mouse_exited_hitbox)
	prop_hitbox.input_event.connect(hitbox_input_event)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if hovered:
		get_viewport().set_input_as_handled()
		scale = scale.move_toward(Vector2(1.1,1.1),0.025)
		z_index = 1
	else:
		scale = scale.move_toward(Vector2(1,1),0.034)
		z_index = 0
	
func mouse_entered_hitbox() -> void:
	hovered = true
	
func mouse_exited_hitbox() -> void:
	hovered = false

func hitbox_input_event(viewport,event,shape_idx) -> void:
	if event is InputEventMouseButton:
		get_viewport().set_input_as_handled()
		SignalHandler.propClicked.emit(is_waldo, self)
	
