extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_name() == "HTML5"):
		$Label2.visible = false
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	AudioManager.get_node("Start").play()
	var _s = get_tree().change_scene("res://levels/Game.tscn")


func _on_CheckButton_toggled(button_pressed):
	Global.enableJoy = button_pressed
