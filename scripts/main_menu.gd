extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var nextLevel = "res://levels/0.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_name() == "HTML5"):
		$Label2.visible = false
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Global.backupDash = 0
	AudioManager.get_node("Start").play()
	var _s = get_tree().change_scene(nextLevel)

func _on_CheckButton_toggled(button_pressed):
	Global.enableJoy = button_pressed


func _on_HSlider_value_changed(value):
	Global.giveDash = 20 - (value/10)
	print(Global.giveDash)
#	pass # Replace with function body.


func _on_Button2_pressed():
	Global.backupDash = 0
	AudioManager.get_node("Start").play()
	Global.currLevel = "res://levels/4.tscn"
	var _s = get_tree().change_scene("res://levels/4.tscn")
