extends Node

var levels = ["hamburguer", "cookie"]
var level: int = 1
var n_levels: int = 2
var enemy
@export var bullet_scene = preload("res://scenes/bullet.tscn")

func next_level():
	level += 1

func prepare_level():
	enemy = load("res://scenes/enemies/" + levels[level -1] + ".tscn")
