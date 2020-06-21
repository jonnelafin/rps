extends "pawn.gd"

enum state { IDLE, CHASE, SHOOT, RETREAT }
export(state) var myState = state.IDLE

export(bool) var AIDisabled = false
onready var Grid = get_parent()
#var type = CellType.ENEMY
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_look_direction(Vector2(1, 0))
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
	update_look_direction(input_direction)
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
#		bump()
		var i = 0
func update_look_direction(direction):
	$Sprite.rotation = direction.angle()
func doAI():
	if(myState == state.IDLE):
		print("		" + name + " : Walking")
		var dir = Vector2(randi()%7-3, randi()%7-3)
		dir.x = max(-1, dir.x)
		dir.y = max(-1, dir.y)
		dir.x = min(1, dir.x)
		dir.y = min(1, dir.y)
		print(dir)
		do_move(dir)
	elif(myState == state.CHASE):
		print("		" + name + " : Chasing")
	elif(myState == state.SHOOT):
		print("		" + name + " : Shooting")
	elif(myState == state.RETREAT):
		print("		" + name + " : Retreating")
	if(is_instance_valid(Global.player)):
		$RayCast2D.cast_to = self.global_position - Global.player.global_position
	else:
		$RayCast2D.cast_to = Vector2(500, 0)
	print($RayCast2D.get_collider())
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
