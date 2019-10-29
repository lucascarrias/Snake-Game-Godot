extends Area2D

onready var grid = get_parent().WINDOW_GRID

func _ready():
	print(grid.y)
	randomize()
	set_rand_pos()

func _physics_process(delta):
	pass
	
func set_rand_pos():
	var pos_x = 32*floor(rand_range(0,  grid.x))
	var pos_y = 32*floor(rand_range(0,  grid.y))
	global_position = Vector2(pos_x, pos_y)


func _on_Apple_body_entered(body):
	if "Snake" in body.name:
		set_rand_pos()
		var snake = body.get_parent()
		snake.size += 1
		snake.score += 1
		
