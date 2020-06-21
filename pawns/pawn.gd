extends Node2D
enum colors { RED, GREEN, YELLOW, BLUE }
enum CellType { Player, OBSTACLE, OBJECT, ENEMY }
export(CellType) var type = CellType.Player
export(colors) var mycolor = colors.RED

func getType():
	return CellType.keys()[type]
func getColor():
	return colors.keys()[mycolor]
func setColor(colorindex):
	mycolor = colorindex

func _ready():
	Global.addPawn(self)

func die(killer):
	Global.removePawn(self, killer)
	get_parent().remove_child(self)
