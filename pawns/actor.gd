extends "pawn.gd"

onready var Grid = get_parent()

func _ready():
	update_look_direction(Vector2(1, 0))



func do_move(input_direction):
	$Pivot/Sprite/Sprite2.visible = false;
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
		bump()


func _process(_delta):
	var input_direction = get_input_direction()
	#print(input_direction)
	var xset = input_direction.x != 0
	var yset = input_direction.y != 0
	var sprint_mult = 1;
	if Input.is_action_pressed("ui_sprint"):
		sprint_mult = 4;
	if(not (xset and yset)):
		$Pivot/Sprite/Sprite2.position = Vector2((65)*sprint_mult, 0);
	else:
		$Pivot/Sprite/Sprite2.position = Vector2((65*1.435)*sprint_mult, 0);
	if(xset or yset):
		$Pivot/Sprite/Sprite2.visible = true;
	else:
		$Pivot/Sprite/Sprite2.visible = false;
	if (not input_direction):
		return
	update_look_direction(input_direction)
	if (not Input.is_action_just_pressed("ui_accept")):
		return
	if Input.is_action_pressed("ui_sprint"):
		for _i in range(4):
			do_move(input_direction)
	else:
		do_move(input_direction)


func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	) #* ((int(Input.is_action_pressed("ui_sprint")) * 2 ) + 1)


func update_look_direction(direction):
	$Pivot/Sprite.rotation = direction.angle()


func move_to(target_position):
	set_process(false)
	$AnimationPlayer.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	$Tween.interpolate_property($Pivot, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	position = target_position

	$Tween.start()

	# Stop the function execution until the animation finished
	yield($AnimationPlayer, "animation_finished")
	
	set_process(true)


func bump():
	set_process(false)
	$AnimationPlayer.play("bump")
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
