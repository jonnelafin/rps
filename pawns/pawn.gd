extends Node2D
enum colors { RED, GREEN, YELLOW }
enum CellType { ACTOR, OBSTACLE, OBJECT, ENEMY }
export(CellType) var type = CellType.ACTOR
