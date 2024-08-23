extends Node

var draggable_object_scene = preload("res://scenes/draggable_object.tscn")
var draggable_physics_scene = preload("res://scenes/physics_drag.tscn")

func _ready():
	# new comment pull
	# second new pull
	var drag_instance_1 = draggable_object_scene.instantiate()
	var block1 = $"Starting Zone2"
	var block2 = $"Ending Zone2"
	var snap_location_1 = block1.position + (block1.scale * block1.size) / 2
	var snap_location_2 = block2.position + (block2.scale * block2.size) / 2
	var snap_array = [snap_location_1, snap_location_2]
	drag_instance_1.snappable_locations.append_array(snap_array)
	print(drag_instance_1.snappable_locations)
	drag_instance_1.default_last_location()
	add_child(drag_instance_1)
	
	var physics_drag_instance_1 = draggable_physics_scene.instantiate()
	physics_drag_instance_1.default_body_and_move($"physics_slot_1")
	add_child(physics_drag_instance_1)
	
	print($"physics_slot_1".get_child(0).size)
	print($"physics_slot_1".get_child(0).scale)
