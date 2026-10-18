extends Node2D

@export var flat_rail: PackedScene = preload("res://scenes/flat_rail.tscn")
@export var inclined_rail: PackedScene = preload("res://scenes/inclined_rail.tscn")
@onready var player = get_node("/root/Game/Player")

var lastBlockLocation = Vector2(300, 200)

func spawn_fr(spawn_position: Vector2) -> void:
	var instance = flat_rail.instantiate()
	instance.global_position = spawn_position
	get_tree().current_scene.add_child(instance)
	
func spawn_ir(spawn_position: Vector2) -> void:
	var instance = inclined_rail.instantiate()
	instance.global_position = spawn_position
	get_tree().current_scene.add_child(instance)
	
	
func _on_timer_timeout():
	
	print(player.global_position)

	var screen_size = get_viewport().get_visible_rect().size
	
	var distance_from_player = lastBlockLocation.x - player.global_position.x
	
	if (distance_from_player < 2000):
		var spawn_inclined = randi_range(0, 9)
		if (spawn_inclined == 8 || spawn_inclined == 9):
			spawn_ir(Vector2(lastBlockLocation.x + 32, lastBlockLocation.y - 32))
			lastBlockLocation.x += 32
			lastBlockLocation.y -= 32
			
		elif (spawn_inclined == 0):
			var spaces = randi_range(1,4)
			lastBlockLocation.x += 32 * spaces
		else:
			spawn_fr(Vector2(lastBlockLocation.x + 32, lastBlockLocation.y))
			lastBlockLocation.x += 32
			
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = .05
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
