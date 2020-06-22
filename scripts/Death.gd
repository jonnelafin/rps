extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var failSafe = 200.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	failSafe = failSafe - 0.1
#	pass
var last = 0
func _input(event):
	if failSafe > 0 and event is InputEventKey and event.is_pressed() and event.scancode  != last:
		
		AudioManager.get_node("Start").play()
		var _s = get_tree().change_scene("res://levels/Game.tscn")
	if(event is InputEventKey):
		last = event.scancode 
