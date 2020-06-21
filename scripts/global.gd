extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addPawn(pawn):
	print("Pawn " + pawn.name + " reporting in.")
func removePawn(pawn):
	print("Pawn " + pawn.name + " reporting dead.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('ui_toggleFullscreen'):
		print("fullscreen toggled")
		OS.window_fullscreen = !OS.window_fullscreen
	if(Input.is_action_just_pressed("ui_cancel")):
		print("Quit...")
		get_tree().quit()
		OS.window_fullscreen = false
	if(Input.is_action_just_pressed("ui_restart")):
		var currentScene = get_tree().get_current_scene().get_filename()
		print(currentScene) # for Debug
		var _s = get_tree().change_scene(currentScene)
		print("Restart")
#	pass
