extends Node2D

# Part 2 Solution

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var elf_nodes : Node2D = $Elfs
onready var cookie_result : RichTextLabel = $CookieResults
var current_total : int
var current_max : Array = [0,0,0]

export var delay = 0.01
var timer = 0.0
var done = false

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if done:
		return
	
	timer += delta
	if timer < delay:
		return
	timer = 0
	
	if elf_nodes.get_child_count() == 0:
		var total = current_max[0] + current_max[1] + current_max[2]
		cookie_result.add_text(String(current_max[0]) + " calories plus " + String(current_max[1]) + " calories plus " + String(current_max[2]) + " calories for a total of " + String(total) + " total calories!")
		done = true
		return
	
	var current_elf = elf_nodes.get_child(0)
	var cookie_hoard = current_elf.get_node("Cookies")
	var cookie = cookie_hoard.get_child(0)
	current_total += cookie.calories
	
	cookie_hoard.remove_child(cookie)
	if cookie_hoard.get_child_count() == 0:
		current_max.push_back(current_total)
		current_max.sort()
		current_max.remove(0)
		
		elf_nodes.remove_child(current_elf)
		for i in range(elf_nodes.get_child_count()):
			var e = elf_nodes.get_child(i)
			e.position.x -= 48
		
		current_total = 0
	else:
		for i in range(cookie_hoard.get_child_count()):
			var c = cookie_hoard.get_child(i)
			c.position.y -= 36
	
	pass
