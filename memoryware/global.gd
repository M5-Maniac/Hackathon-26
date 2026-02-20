extends Node2D

signal propClicked(is_waldo: bool, clicked_prop: Node2D)
signal propDropped(dropped_prop: Node2D)

var inputHandled: bool = false #boolean thats true when hovering or grabbing a prop, to avoid overlap/grabbing multiple.
var lives = 3
