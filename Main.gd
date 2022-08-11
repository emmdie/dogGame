extends Node

export(PackedScene) var stone_scene
export(PackedScene) var fish_scene
var score

func _ready():
	randomize()
