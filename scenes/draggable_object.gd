extends Sprite2D

# Array of valid locations, Index 0 is default location or starting location
@export var snappable_locations: Array[Vector2] = []
@export var min_distance_to_snap = 100
var last_location: Vector2

var being_dragged: bool = false
var relative_click_distance: Vector2;

func _ready():
	# if default location exists, assign it to last location.
	# otherwise last_location is the position at instanciation
	if snappable_locations.size() > 0:
		last_location = snappable_locations[0]
		position = last_location
	else:
		print("Will not snap, can move freely")

func _input(event):
	#print("Registering event")
	var mouse_position = get_viewport().get_mouse_position()
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Event is mouse 1 press")
		if get_rect().has_point(to_local(event.position)):
			print("setting dragged to true")
			being_dragged = true
			relative_click_distance = event.position - position
	elif event is InputEventMouseButton and !event.pressed and event.button_index == MOUSE_BUTTON_LEFT and being_dragged:
		print("Event is mouse 1 release")
		being_dragged = false
		
		if snappable_locations.size() > 0:
			print("entering snappable location condition")
			var temp_closest_index = 0
			var temp_closest = mouse_position.distance_squared_to(snappable_locations[temp_closest_index])
			for i in range(snappable_locations.size()):
				print("Checking index ", i)
				var temp_distance = mouse_position.distance_squared_to(snappable_locations[i])
				if temp_distance < temp_closest: 
					temp_closest = temp_distance
					temp_closest_index = i
				print("closest index is ", temp_closest_index)
			if pow(temp_closest, 0.5) < min_distance_to_snap:
				position = snappable_locations[temp_closest_index]
				last_location = snappable_locations[temp_closest_index]
			else:
				print("Not close enough to snap")
				position = last_location
		
	if being_dragged == true:
		#print("repositioning object")
		position = mouse_position - relative_click_distance

func default_last_location():
	if snappable_locations.size() > 0:
		last_location = snappable_locations[0]
