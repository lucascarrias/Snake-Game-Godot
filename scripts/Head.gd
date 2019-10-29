extends KinematicBody2D

const WINDOW_SIZE = Vector2(1024, 640)

var RIGHT = false
var LEFT = false
var UP = false
var DOWN = false
var move
var move_delay = 0.1
var started = false

export var velocity = 32
var last_pos = global_position

func _ready():
	pass

func _physics_process(delta):
	kill()

func movement():
	if arrow_pressed():
		if Input.is_action_pressed("ui_right") and !LEFT:
			RIGHT = true
			LEFT = false
			UP = false
			DOWN = false
		if Input.is_action_pressed("ui_left") and !RIGHT:
			LEFT =  true
			RIGHT = false
			UP = false
			DOWN = false			
		if Input.is_action_pressed("ui_up") and !DOWN:
			UP = true
			RIGHT = false
			LEFT = false
			DOWN = false
		if Input.is_action_pressed("ui_down") and !UP:
			DOWN = true
			RIGHT = false
			LEFT = false
			UP = false
		started = true		
		
	if move:
		last_pos = global_position
		var dir = head_direction()
		global_position += move(Vector2(velocity*dir.x, velocity*dir.y))
	

func arrow_pressed():
	var keys = ["ui_right", "ui_left", "ui_up", "ui_down"]
	for key in keys:
		if Input.is_action_just_pressed(key):
			return true
	return false

func move(direction):
	var pos = global_position + direction
	if (pos.x >= 0 and pos.y >= 0) and (pos.x <= WINDOW_SIZE.x and pos.y <=WINDOW_SIZE.y):
		return direction
	else:
		started = false		
		$Death.start()
		get_parent().set_physics_process(false)
		return Vector2(0,0)

func _on_Move_Delay_timeout():
	$Move_Delay.stop()
	move = true

func set_Timer_move(value):
	$Move_Delay.wait_time = value

func set_move_delay(value):
	move_delay = value

func head_direction():
	if RIGHT: return Vector2(1,0)
	elif LEFT: return Vector2(-1,0)
	elif UP: return Vector2(0,-1)
	elif DOWN: return Vector2(0,1)
	else: return Vector2(0,0)

func kill():
	if $Death.is_stopped():
		for i in get_parent().get_child_count():
			if i > 1:
				var part = get_parent().get_child(i)
				if part.name != self.name:
					if part.global_position == global_position:
						started = false
						$Death.start()
						$Move_Delay.stop()
					

func _on_Death_timeout():
	get_tree().reload_current_scene()
