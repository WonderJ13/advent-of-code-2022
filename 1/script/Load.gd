extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elf_scene = preload("res://entity/Elf.tscn")
var cookie_scene = preload("res://entity/Cookie.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://input.txt", File.READ)

	var content = file.get_as_text()
	file.close()

	var elf_contents = content.split("\n\n")
	for i in range(elf_contents.size()):
		#Create elf for each cookie-group
		var elf_istn = elf_scene.instance()
		var elfs_cookies = elf_istn.find_node("Cookies")
		var calorie_counts = elf_contents[i].split("\n")
		
		elf_istn.position.x = (i+2)*48
		elf_istn.position.y = 35

		for j in range(calorie_counts.size()):
			#Create cookie for elf to hold
			var cookie_istn = cookie_scene.instance()
			cookie_istn.calories = calorie_counts[j].to_int()
			cookie_istn.position.y = (j+1)*36 + 17
			elfs_cookies.add_child(cookie_istn)
		
		add_child(elf_istn)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
