extends Node2D

@onready var click_particle: Node2D = $"../ClickParticle"
@onready var task_label: RichTextLabel = $"../TaskLabel"
@onready var props: Node2D = $"."


const BACKPACK = preload("uid://cvljajd2i4ced")
const TRASHCAN = preload("uid://c4f5qnfb43vx2")
const TREE = preload("uid://bxes020iwqd6c")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var prop_count = get_child_count()
	#var waldo_prop = randi_range(0,prop_count-1)
	#get_child(waldo_prop).is_waldo = true #random prop selection
	var waldo = BACKPACK.instantiate()
	waldo.position.x = randi_range(-240,240)
	waldo.position.y = randi_range(-130,130)
	waldo.is_waldo = true
	waldo.color = waldo.colors.gray
	props.add_child(waldo)
	task_label.text = "Find the " + str(waldo.colors.find_key(waldo.color)) + " " + str(waldo.objects.find_key(waldo.object)) + "!"
	
	SignalHandler.propClicked.connect(prop_clicked)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func prop_clicked(is_waldo,clicked_prop) -> void:
	if is_waldo:
		clicked_prop.queue_free()
		click_particle.emitting = true
		click_particle.position = get_global_mouse_position()
		
