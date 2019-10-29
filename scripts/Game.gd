extends Node2D

const WINDOW_SIZE = Vector2(1024, 640)
var WINDOW_GRID = Vector2(WINDOW_SIZE.x/32, WINDOW_SIZE.y/32)
var max_score = 0

func _ready():
	$Background.visible = true	
	max_score = int(load_score())

func _process(delta):
	show_score()
	
func show_score():
	if $Snake.score > max_score:
		max_score = $Snake.score
		save(str(max_score))
	$Score/Label.text = "Max Score: " + str(max_score) + "\nScore: " + str($Snake.score)

func save(content):
    var file = File.new()
    file.open("res://score.dat", file.WRITE)
    file.store_string(content)
    file.close()

func load_score():
    var file = File.new()
    file.open("res://score.dat", file.READ)
    var content = file.get_as_text()
    file.close()
    return content