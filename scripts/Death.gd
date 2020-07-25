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
	if failSafe < 197 and Joy.actionPressed:
		AudioManager.get_node("Start").play()
		var currentScene = Global.currLevel
		print(currentScene) # for Debug
		var _s = get_tree().change_scene(currentScene)
		print("Restart")
#	pass
var last = 0
func _input(event):
	if failSafe > 0 and event is InputEventKey and event.is_pressed() and event.scancode  != last:
		
		AudioManager.get_node("Start").play()
		var currentScene = Global.currLevel
		print(currentScene) # for Debug
		var _s = get_tree().change_scene(currentScene)
		print("Restart")
	if(event is InputEventKey):
		last = event.scancode 
