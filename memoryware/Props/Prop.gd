
extends Node2D
 #classification
enum objects { trashcan, backpack, tree, snail } #list of possible objects
enum colors { red, orange, yellow, green, blue, purple, white, gray, black }
@export var object = objects.trashcan
@export var color = colors.blue
@export var flip_h: bool = false #Is the object's sprite flipped horizontally?
@export var is_waldo: bool = false #Object the player is supposed to click.

@export var x_range: int = 0
@export var y_range: int = 0
@export var anchor_pos: Vector2 = Vector2(0,0)
@export var speed: float = 1

var prop_hitbox
var prop_sprite
var markers: Array
var hovered: bool = false
var grabbed: bool = false
var grab_offset: Vector2

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
			prop_sprite.modulate = Color(0.479, 0.89, 1.601, 1.0)
		elif color == colors.purple:
			prop_sprite.modulate = Color(1,0.43,1.33)
			
		
		
	
	prop_hitbox.mouse_entered.connect(mouse_entered_hitbox)
	prop_hitbox.mouse_exited.connect(mouse_exited_hitbox)
	prop_hitbox.input_event.connect(hitbox_input_event)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if grabbed: #Code for dragging props.
		scale = scale.move_toward(Vector2(1.16,1.16),0.025)
		position = get_global_mouse_position()-grab_offset
		z_index = 1
	elif hovered: #Scales up prop based on hovered bool.
		if !Global.inputHandled:
			scale = scale.move_toward(Vector2(1.08,1.08),0.025)
	else: #If the prop is neither hovered o'er, nor grabbed.
		scale = scale.move_toward(Vector2(1,1),0.034)
		z_index = 0
		
	#Moving props
	if x_range != 0:
		position.x += x_range * sin(Time.get_ticks_msec()*speed/2500+speed)*delta
		#sprite direction
		if sin(Time.get_ticks_msec()*speed/2500+speed) < 0:
			scale.x = -1
		else:
			scale.x = 1
	if y_range != 0:
		position.y += y_range * sin(Time.get_ticks_msec()*speed/2500+speed)*delta
	
func mouse_entered_hitbox() -> void:
	if !Global.inputHandled:
		hovered = true
	
func mouse_exited_hitbox() -> void:
	hovered = false

func hitbox_input_event(viewport,event,shape_idx) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if !Global.inputHandled:
				Global.inputHandled = true
				grabbed = true
				Global.propClicked.emit(is_waldo, self)
		else:
			if grabbed:
				Global.propDropped.emit(self)
			Global.inputHandled = false
			grabbed = false
			
		grab_offset = get_global_mouse_position()-position
	
