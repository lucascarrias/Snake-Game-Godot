extends Node2D

var SEGMENT = preload("res://scenes/SnakeSegment.tscn")

export (int) var size = 3
var body_index = 1
onready var last_pos = $Head.global_position
var score = 0

func _ready():
	create_body()

func _physics_process(delta):
	move_body()

func create_body():
	var last_pos_x = $Head.global_position.x
	if size >= get_child_count():
		for i in range(0,size):
			var segment = SEGMENT.instance()
			if !get_child(i):
				add_child(segment)
			get_child(i).global_position = Vector2(last_pos_x-32*i, last_pos.y)
		$Head.global_position.x -= 32 

func move_segment(body_part, pos):
	body_part.global_position = pos

func move_segments(head_pos):
	var current_pos
	var last_pos = head_pos
	var body_len = get_child_count()
	for i in range(1,body_len):
		var segment = get_child(i)
		current_pos = segment.global_position
		segment.global_position = last_pos
		last_pos = current_pos
		$Head/Move_Delay.start()
	add_segment(last_pos)

func move_body():
	$Head.set_Timer_move($Head.move_delay/(1+score/50.0))
	$Head.movement()
	if $Head.started and $Head.move:
		move_segments($Head.global_position)
		$Head.move = false

func add_segment(last_pos):
	if size > get_child_count():
		var segment = SEGMENT.instance()
		add_child(segment)
		var body_len = get_child_count()		
		get_child(body_len - 1).global_position = Vector2(last_pos.x, last_pos.y)
