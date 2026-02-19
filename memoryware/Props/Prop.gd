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
var markers: Array
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
		if child.name == "Sides":
			for marker in child.get_children():
				markers.append(marker)
			
	if true: 
		if color == colors.gray:
			prop_sprite.modulate = Color(1,1,1)
		elif color == colors.white:
			prop_sprite.modulate = Color(2,2,2)
		elif color == colors.black:
			prop_sprite.modulate = Color(0.5,0.5,0.5)
		elif color == colors.red:
			prop_sprite.modulate = Color(1.4,0.00,0.1)
		elif color == colors.orange:
			prop_sprite.modulate = Color(1.67, 0.74, 0.0)
		elif color == colors.yellow:
			prop_sprite.modulate = Color(1.86, 1.4, 0.0)
		elif color == colors.green:
			prop_sprite.modulate = Color(0.0,1.25,0.47)
		elif color == colors.blue:
			prop_sprite.modulate = Color(1,0.43,1.33)
		elif color == colors.purple:
			prop_sprite.modulate = Color(1,0.43,1.33)
			
		
		
	
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
	
