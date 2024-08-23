extends Area2D

var being_dragged : bool = false
var mouse_in : bool = false
var relative_click_distance : Vector2
var ready_to_snap: bool = false
var last_body : Node2D
var temp_body : Node2D

func _input(event):
	# adding comment to test
	#print("Registering event")
	var mouse_position = get_viewport().get_mouse_position()
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Event is mouse 1 press")
		if mouse_in:
			print("setting dragged to true")
			being_dragged = true
			relative_click_distance = event.position - position
	elif event is InputEventMouseButton and !event.pressed and event.button_index == MOUSE_BUTTON_LEFT and being_dragged:
		print("Event is mouse 1 release")
		being_dragged = false
		var temp_child : ColorRect
		if ready_to_snap :
			temp_child = temp_body.get_child(0)
			position = temp_body.position + (temp_child.size * temp_body.scale) / 2
			last_body = temp_body
		else :
			temp_child = last_body.get_child(0)
			position = last_body.position + (temp_child.size * last_body.scale) / 2
			
		
	if being_dragged == true:
		#print("repositioning object")
		position = mouse_position - relative_click_distance


func _on_mouse_entered():
	print("mouse entered")
	mouse_in = true

func _on_mouse_exited():
	print("mouse exited")
	mouse_in = false

func _on_body_entered(body):
	print("body entered")
	ready_to_snap = true
	temp_body = body

func _on_body_exited(_body):
	print("body exited")
	ready_to_snap = false

func default_body_and_move(body):
	last_body = body
	var temp_child = last_body.get_child(0)
	position = last_body.position + (temp_child.size * last_body.scale) / 2
