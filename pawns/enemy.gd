extends "pawn.gd"

export(bool) var AIDisabled = false

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
