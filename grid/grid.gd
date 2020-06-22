extends TileMap

enum CellType { EMPTY = -1, Player, OBSTACLE, OBJECT, ENEMY}

func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)


func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)


func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	if(get_cell_pawn(cell_target) != pawn):
		match cell_target_type:
			CellType.EMPTY:
				return update_pawn_position(pawn, cell_start, cell_target)
			CellType.OBJECT:
				var object_pawn = get_cell_pawn(cell_target)
				var next = object_pawn.nextLevel
				#var curDash = pawn.Dash
				Global.backupDash = Global.player.Dash
				var _s = get_tree().change_scene(next)
				#Global.player.Dash = curDash
				object_pawn.queue_free()
				return update_pawn_position(pawn, cell_start, cell_target)
			CellType.Player:
				#var pawn_name = get_cell_pawn(cell_target).name
				#print("Cell %s contains %s" % [cell_target, pawn_name])
				var pawn_at = get_cell_pawn(cell_target)
				if(pawn.getType() == "ENEMY"):
					pawn.setColor(pawn_at.mycolor)
					set_cellv(cell_target, CellType.EMPTY)
					pawn_at.visible = false
					Global.playerDeath()
					#pawn_at.die(pawn)
					return update_pawn_position(pawn, cell_start, cell_target)
			CellType.ENEMY:
				if not is_instance_valid(get_cell_pawn(cell_target)):
					return
				var deny = true
				var pawn_at = get_cell_pawn(cell_target)
			#	var pawn_name = pawn_at.name
			#	print("Cell %s contains enemy %s" % [cell_target, pawn_name])
				
				if(pawn.getType() == "Player"):
					if(pawn.running):
						deny = false
					if(not deny):
						if(pawn.mycolor != pawn_at.mycolor):
							AudioManager.get_node("Change").play()
						pawn.setColor(pawn_at.mycolor)
						
				if(pawn.mycolor == pawn_at.mycolor):
					if(pawn.getType() == "Player" and pawn.Dash < 100.0 and not pawn.running):
						pawn.Dash = pawn.Dash + 20.0
					set_cellv(cell_target, CellType.EMPTY)
					pawn_at.die(pawn)
					deny = false
				if(deny):
					return
				return update_pawn_position(pawn, cell_start, cell_target)


func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, CellType.EMPTY)
	return map_to_world(cell_target) + cell_size / 2
