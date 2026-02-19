extends Node2D

@onready var click_particle: Node2D = $"../ClickParticle"
@onready var task_label: RichTextLabel = $"../Camera2D/TaskLabel"
@onready var props: Node2D = $"."
@onready var transition: ColorRect = $"../Transition"

@export var backpack_count: int = 10
@export var tree_count: int = 10
@export var trashcan_count: int = 10

const BACKPACK = preload("uid://cvljajd2i4ced")
const TRASHCAN = preload("uid://c4f5qnfb43vx2")
const TREE = preload("uid://bxes020iwqd6c")

var waldo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var prop_count = get_child_count()
	#var waldo_prop = randi_range(0,prop_count-1)
	#get_child(waldo_prop).is_waldo = true #random prop selection
	
	waldo = BACKPACK.instantiate()
	waldo.position.x = randi_range(-240,240)
	waldo.position.y = randi_range(-130,130)
	waldo.is_waldo = true
	waldo.color = randi_range(0,waldo.colors.size()-1)
	props.add_child(waldo)
	
	for backpacks in range(backpack_count): #backpacks
		var new_backpack = BACKPACK.instantiate()
		new_backpack.position.x = randi_range(-240,240)
		new_backpack.position.y = randi_range(-130,130)
		new_backpack.flip_h = (randf() < 0.5)
		new_backpack.color = randi_range(0,new_backpack.colors.size()-1)
		while new_backpack.color == waldo.color:
			new_backpack.color = randi_range(0,new_backpack.colors.size()-1)
		props.add_child(new_backpack)

	task_label.text = "Find the " + str(waldo.colors.find_key(waldo.color)) + " " + str(waldo.objects.find_key(waldo.object)) + "!"
	
	SignalHandler.propClicked.connect(prop_clicked)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transition.position = transition.position.move_toward(Vector2(484,-186),25)

func prop_clicked(is_waldo,clicked_prop) -> void:
	if is_waldo:
		clicked_prop.queue_free()
		click_particle.emitting = true
		click_particle.position = get_global_mouse_position()
		
func positioijjg4bi(is_waldo,clicked_prop) -> void:
	pass
