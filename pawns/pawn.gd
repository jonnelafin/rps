extends Node2D

enum CellType { ACTOR, OBSTACLE, OBJECT, ENEMY }
export(CellType) var type = CellType.ACTOR
