extends "pawn.gd"

enum state { IDLE, WALK, CHASE, SHOOT, RETREAT, SEARCH }
export(state) var myState = state.IDLE

export(bool) var AIDisabled = false
onready var Grid = get_parent()
onready var navigation = get_parent().get_parent()

var overrideDetected
var detected
var sos = 0.0
var lastAct
var pure = true
#var type = CellType.ENEMY
# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	update_look_direction(Vector2(1, 0))
	$Sprite.rotation = rotation
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
func setRot(rot):
	$Sprite.rotation = rot
func doAI():
	set_process(false)
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
		for actor in Global.pawns:
			if is_instance_valid(actor) and actor is preload("res://pawns/pawn.gd") and actor.type == CellType.ENEMY and actor != self and pure and not is_instance_valid(actor.overrideDetected):
				print(actor.global_position.distance_to(global_position))
				if actor.global_position.distance_to(global_position) < 250:
					print("		" + name + " alerted " + actor.name)
					#actor.detected = detected
					actor.overrideDetected = detected
					actor.sos = 1
					#actor.myState = state.CHASE
					#actor.setRot($Sprite.rotation)
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
			var dir2 = Vector2(randi()%3-1, randi()%3-1)
			dir2.x = max(-1, dir.x)
			dir2.y = max(-1, dir.y)
			dir2.x = min(1, dir.x)
			dir2.y = min(1, dir.y)
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
		else:
			var dir = Vector2(randi()%7-3, randi()%7-3)
			dir.x = max(-1, dir.x)
			dir.y = max(-1, dir.y)
			dir.x = min(1, dir.x)
			dir.y = min(1, dir.y)
			print(dir)
			do_move(dir)
#	if(is_instance_valid(Global.player)):
#		$RayCast2D.cast_to = self.global_position - Global.player.global_position
#	else:
#		$RayCast2D.cast_to = Vector2(500, 0)
	
		#$Sprite/marker.points[1].x = -$Sprite/marker.points[1].x
		#$Sprite/marker.points[1].y = -$Sprite/marker.points[1].y
	#print(detected)
	if(is_instance_valid(overrideDetected)):
		pure = false
		detected = overrideDetected
		if(sos < 2):
			overrideDetected = null
		else:
			sos = sos -1
	else:
		raycast()
		pure = true
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
	var to = Vector2(420, 0)
	detected = $Sprite/RayCast2D.get_collider()
	var last = $Sprite/RayCast2D.get_collision_point()
	for i in range((3000/4)/2):
		i = i * 4
		to = Vector2(420, i-(1500)/2)
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
	to = Vector2(450, 0)
	$Sprite/RayCast2D.cast_to = to
	$Sprite/RayCast2D.force_raycast_update()
	#detected = $Sprite/RayCast2D.get_collider()
	$Sprite/marker.visible = false
	if(is_instance_valid(detected)):
		$Sprite/marker.visible = true
		if not (detected is TileMap):
			$Sprite/marker.points[1] = $Sprite.to_local(detected.global_position)
			detected = detected.get_parent()
		else:
			$Sprite/marker.points[1] = $Sprite.to_local(last)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = 0
	if(myState == state.CHASE):
		$Warn.visible = true
	else: 
		$Warn.visible = false
	pass
