extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var actionPressed = false
var sprint = false
func toggleSprint(next):
	$MarginContainer/Joystick_Control/Button2.pressed = next
	sprint = next
func toggleJoy(next):
	if next:
		$MarginContainer.show()
	else:
		$MarginContainer.hide()
#	$MarginContainer/Joystick_Control/Joystick.visible = next

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Button_button_down():
	actionPressed = true



func _on_Button_button_up():
	actionPressed = false


func _on_Button2_toggled(button_pressed):
	sprint = button_pressed
	print(sprint)
