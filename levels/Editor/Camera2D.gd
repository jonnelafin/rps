extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var last = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	last = get_viewport().get_mouse_position()
	pass # Replace with function body.
func _unhandled_input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
			# zoom in
#			if event.button_index == BUTTON_WHEEL_UP:
#				zoom_pos = get_global_mouse_position()
#				$Camera2D.zoom = $Camera2D.zoom + Vector2(0.1, 0.1)
				# call the zoom function
			# zoom out
#			if event.button_index == BUTTON_WHEEL_DOWN:
#				zoom_pos = get_global_mouse_position()
#				$Camera2D.zoom = $Camera2D.zoom - Vector2(0.1, 0.1)
				# call the zoom function
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Camera2D.zoom < Vector2(0.1, 0.1)):
		$Camera2D.zoom = Vector2(0.1, 0.1)
	if(Input.is_mouse_button_pressed(2)):
		global_position = global_position + ((last - get_viewport().get_mouse_position()) *$Camera2D.zoom)
	if Input.is_action_just_released("ui_su"):
		$Camera2D.zoom = $Camera2D.zoom - Vector2(0.1, 0.1)
	if Input.is_action_just_released("ui_sd"):
		$Camera2D.zoom = $Camera2D.zoom +  Vector2(0.1, 0.1)
	last = get_viewport().get_mouse_position()
	if($Camera2D.zoom < Vector2(0.1, 0.1)):
		$Camera2D.zoom = Vector2(0.1, 0.1)
#	pass
