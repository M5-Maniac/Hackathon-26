extends Node2D

@onready var click_particle: Node2D = $"../ClickParticle"
@onready var task_label: RichTextLabel = $"../Camera2D/TaskLabel"
@onready var props: Node2D = $"."
@onready var transition: ColorRect = $"../Transition"


@export var backpack_count: int = 15
@export var tree_count: int = 5
@export var trashcan_count: int = 10
@export var snail_count: int = 10

const BACKPACK = preload("res://Props/Backpack.tscn")
const TRASHCAN = preload("res://Props/Trashcan.tscn")
const TREE = preload("res://Props/Tree.tscn")
const TREE_2 = preload("res://Props/Tree2.tscn")
const SNAIL = preload("res://Props/Snail.tscn")


enum waldo_types { only_color, only_movement, only_stopped}
var color_props: Array = [BACKPACK,SNAIL] #Props that can be differentiated by color.
var no_movement_props: Array = [TREE,TREE_2,TRASHCAN,BACKPACK] #Props that are typically stationary.
var movement_props: Array = [SNAIL] #Props that normally move.

var waldo
var waldo_type = waldo_types.only_color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var prop_count = get_child_count()
	
	#WALDO SPAWNING
	decide_waldo()
	match waldo_type:
		0:
			task_label.text = "Find the " + str(waldo.colors.find_key(waldo.color)) + " " + str(waldo.objects.find_key(waldo.object)) + "!"
		1:
			task_label.text = "Find the only moving " + str(waldo.objects.find_key(waldo.object)) + "!"
		2:
			task_label.text = "Find the only stationary " + str(waldo.objects.find_key(waldo.object)) + "!"

	#EXTRA PROP SPAWNING
	for backpacks in range(backpack_count): #backpacks
		var new_prop = BACKPACK.instantiate()
		spawnProp(new_prop, true, true)
	for trashcans in range(trashcan_count): #backpacks
		var new_prop = TRASHCAN.instantiate()
		spawnProp(new_prop, false, false)
	for trees in range(tree_count): #backpacks
		if randf() < 0.5:
			var new_prop = TREE.instantiate()
			spawnProp(new_prop, false, false)
		else:
			var new_prop = TREE_2.instantiate()
			spawnProp(new_prop, false, false)
	for snails in range(snail_count): #backpacks
		var new_prop = SNAIL.instantiate()
		spawnProp(new_prop, true, false)
		new_prop.x_range = randi_range(10,50)
		new_prop.speed = randf_range(0.3,1)
		
	#SIGNAL CONNECTIONS
	Global.propClicked.connect(prop_clicked)
	Global.propDropped.connect(prop_dropped)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass 
	
#WHEN A PROP IS CLICKED
func prop_clicked(is_waldo,clicked_prop) -> void:
	if is_waldo:
		clicked_prop.queue_free()
		click_particle.emitting = true
		click_particle.position = get_global_mouse_position()

#WHEN A PROP IS DROPPED
func prop_dropped(dropped_prop) -> void:
	for prop in get_children():
		pass #want to add behavior here later to sort nodes based on y-value

#FUNCTION FOR SPAWNING PROPS
func spawnProp(new_prop, colored: bool, flip_h: bool) -> void:
	new_prop.position.x = randi_range(-240,240)
	new_prop.position.y = randi_range(-130,130)
	new_prop.orig_pos = new_prop.position
	if flip_h:
		new_prop.flip_h = (randf() < 0.5)
	if colored:
		new_prop.color = randi_range(0,new_prop.colors.size()-1)
		while new_prop.color == waldo.color:
			new_prop.color = randi_range(0,new_prop.colors.size()-1)
	props.add_child(new_prop)
	#THIS CODE IS BROKEN RN DOESNT WORK. need to fix
	while new_prop.prop_hitbox.get_overlapping_areas().size()>0:
		new_prop.position.x = randi_range(-240,240)
		new_prop.position.y = randi_range(-130,130)
		new_prop.orig_pos = new_prop.position
		print("hello")

#Function that decides which waldo question to ask, and sets the prop.
func decide_waldo():
	var waldo_prop
	waldo_type = randi_range(0,waldo_types.size()-1) #0: diff color, 1: no movement
	match waldo_type:
		0: #DIFFERENT COLOR
			waldo_prop = color_props[randi_range(0,color_props.size()-1)]
			waldo = waldo_prop.instantiate()
			waldo.position.x = randi_range(-230,230)
			waldo.position.y = randi_range(-110,110)
			waldo.orig_pos = waldo.position
			waldo.color = randi_range(0,waldo.colors.size()-1)
			props.add_child(waldo)
		1: #ONLY MOVING PROP OF A NON-MOVING TYPE
			waldo_prop = no_movement_props[randi_range(0,no_movement_props.size()-1)]
			waldo = waldo_prop.instantiate()
			waldo.position.x = randi_range(-230,230)
			waldo.position.y = randi_range(-110,110)
			waldo.orig_pos = waldo.position
			waldo.color = randi_range(0,waldo.colors.size()-1)
			if randf()<0.5:
				waldo.x_range = randi_range(20,30)
			else:
				waldo.y_range = randi_range(15,25)
			waldo.speed = randf_range(0.25,0.35)
			props.add_child(waldo)
		2: #ONLY NON-MOVING PROP OF A MOVING TYPE
			waldo_prop = movement_props[randi_range(0,movement_props.size()-1)]
			waldo = waldo_prop.instantiate()
			waldo.position.x = randi_range(-230,230)
			waldo.position.y = randi_range(-110,110)
			waldo.orig_pos = waldo.position
			waldo.color = randi_range(0,waldo.colors.size()-1)
			props.add_child(waldo)
	waldo.is_waldo = true
