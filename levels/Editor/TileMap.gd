extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func snap(x, base):
	return int((base * float(int(x)/base)))
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_mouse_button_pressed(1)):
		var pos = (($Node2D/Camera2D.global_position - (get_viewport().get_mouse_position()*$Node2D/Camera2D.zoom))*-1)-(get_viewport().size/2)
		$Sprite.global_position.x = snap(pos.x, 32)
		$Sprite.global_position.y = snap(pos.y, 32)
#	pass
