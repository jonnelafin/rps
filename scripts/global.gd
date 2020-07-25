extends Node

var pawns = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currLevel = ""

var giveDash = 20

var enableJoy = true
var joyIn = Vector2.ZERO

var player
var backupDash = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	currLevel = get_tree().get_current_scene().get_filename()
#	pass # Replace with function body.

func addPawn(pawn):
	print("Pawn \"" + pawn.name + "\" reporting in.")
	pawns.append(pawn)
func removePawn(pawn, killer):
	print("Pawn \"" + pawn.name + "\" reporting dead, killed by " + killer.name)
	if(pawns.has(pawn)):
		pawns.remove(pawns.find(pawn))
	else:
		print("pawn was not on the list")
func clearPawns():
	pawns = []

func doAI():
	if(pawns.size() > 0):
		print("Executing AI tasks...")
	else:
		print("No AI Pawns Present.")
	for pawn in pawns:
		if(is_instance_valid(pawn) and pawn is preload("res://pawns/pawn.gd")):
			if(pawn.getType() == "ENEMY"):
				if(not pawn.AIDisabled):
					print("		Enemy " + pawn.name + " doing stuff...")
					pawn.doAI()
				else:
					print("		Enemy " + pawn.name + " has AI disabled.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('ui_toggleFullscreen'):
		print("fullscreen toggled")
		OS.window_fullscreen = !OS.window_fullscreen
	if(Input.is_action_just_pressed("ui_cancel")):
		print("Quit...")
		var _s = get_tree().change_scene("res://Start.tscn")
		#get_tree().quit()
		#OS.window_fullscreen = false
	if(Input.is_action_just_pressed("ui_restart")):
		var currentScene = get_tree().get_current_scene().get_filename()
		print(currentScene) # for Debug
		var _s = get_tree().change_scene(currentScene)
		print("Restart")
#	pass
func playerDeath():
	clearPawns()
	var _s = get_tree().change_scene("res://scripts/Death.tscn")
