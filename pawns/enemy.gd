extends "pawn.gd"



#var type = CellType.ENEMY
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	type = CellType.ENEMY
	match mycolor:
		colors.RED:
			$Sprite.texture = load("res://pawns/enemies/r.png")
		colors.GREEN:
			$Sprite.texture = load("res://pawns/enemies/g.png")
		colors.YELLOW:
			$Sprite.texture = load("res://pawns/enemies/y.png")
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
