extends "pawn.gd"

export(bool) var AIDisabled = false
onready var Grid = get_parent()
#var type = CellType.ENEMY
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	type = CellType.ENEMY
	match mycolor:
		colors.RED:
			$Sprite.texture = load("res://textures/pawns/r.png")
		colors.GREEN:
			$Sprite.texture = load("res://textures/pawns/g.png")
		colors.YELLOW:
			$Sprite.texture = load("res://textures/pawns/y.png")
		colors.BLUE:
			$Sprite.texture = load("res://textures/pawns/character.png")
#	pass # Replace with function body.
func do_move(input_direction):
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
#		bump()
		var i = 0
func doAI():
	print("		" + name + " : Walking")
	var dir = Vector2(randi()%3-1, randi()%3-1)
	do_move(dir)
func move_to(target_position):
	set_process(false)

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	position = target_position
	
	set_process(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
