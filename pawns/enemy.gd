extends "pawn.gd"

enum state { IDLE, WALK, CHASE, SHOOT, RETREAT, SEARCH }
export(state) var myState = state.IDLE

export(bool) var AIDisabled = false
onready var Grid = get_parent()
onready var navigation = get_parent().get_parent()

var detected
var sos = 0.0
var lastAct
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
	set_process(false)
	raycast()
	if(is_instance_valid(detected) and detected.is_in_group("players")):
		if(myState != state.CHASE and myState != state.SEARCH):
			lastAct = myState
		myState = state.CHASE
	#	print("Detected! \nStarting chase...")
	if(myState == state.IDLE):
		print("		" + name + " : IDLE")
	elif(myState == state.WALK):
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
		if(not (is_instance_valid(detected) and detected.is_in_group("players"))):
			myState = state.SEARCH
			sos = 3
		else:
			var dir = global_position - detected.global_position
			dir.x = min(1, dir.x)
			dir.y = min(1, dir.y)
			dir.x = max(-1, dir.x)
			dir.y = max(-1, dir.y)
			dir = -dir
			print("Dir: " + str(dir))
			var lastDir = $Sprite.rotation
			do_move(dir)
			$Sprite.rotation = lastDir
			#var points = navigation.get_simple_path(global_position, detected.global_position, false)
			#print(global_position)
			#print(points)
	elif(myState == state.SHOOT):
		print("		" + name + " : Shooting")
	elif(myState == state.RETREAT):
		print("		" + name + " : Retreating")
	elif(myState == state.SEARCH):
		print("		" + name + " : Searching")
		sos = sos - 1
		if(sos < 1):
			myState = lastAct
#	if(is_instance_valid(Global.player)):
#		$RayCast2D.cast_to = self.global_position - Global.player.global_position
#	else:
#		$RayCast2D.cast_to = Vector2(500, 0)
	
		#$Sprite/marker.points[1].x = -$Sprite/marker.points[1].x
		#$Sprite/marker.points[1].y = -$Sprite/marker.points[1].y
	#print(detected)
	set_process(true)
func move_to(target_position):
	set_process(false)

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	position = target_position
	
	set_process(true)
func raycast():
	$Sprite/Line2D.visible = false#not AIDisabled
	var to = Vector2(1000, 0)
	detected = $Sprite/RayCast2D.get_collider()
	var last = $Sprite/RayCast2D.get_collision_point()
	for i in range(3000):
		to = Vector2(1000, i-1500)
		$Sprite/RayCast2D.cast_to = to
		$Sprite/RayCast2D.force_raycast_update()
		#$Sprite/Line2D.points[1] = Vector2(500, i-500)
		if(is_instance_valid($Sprite/RayCast2D.get_collider())):
			if(not is_instance_valid(detected)) and ($Sprite/RayCast2D.get_collider() is TileMap):
				detected = $Sprite/RayCast2D.get_collider()
				last = $Sprite/RayCast2D.get_collision_point()
			elif not ($Sprite/RayCast2D.get_collider() is TileMap):
				detected = $Sprite/RayCast2D.get_collider()
				last = $Sprite/RayCast2D.get_collision_point()
	to = Vector2(1000, 0)
	$Sprite/RayCast2D.cast_to = to
	$Sprite/RayCast2D.force_raycast_update()
	#detected = $Sprite/RayCast2D.get_collider()
	$marker.visible = false
	if(is_instance_valid(detected)):
		$marker.visible = true
		if not (detected is TileMap):
			$marker.points[1] = to_local(detected.global_position)
			detected = detected.get_parent()
		else:
			$marker.points[1] = to_local(last)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass
