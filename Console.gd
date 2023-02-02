extends LineEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var input_text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Console_text_entered(new_text):
	input_text = new_text
	var token = ""
	var iteration = 0
	var command = ""
	var args = ""
	var charCount = 1
	for l in input_text:
		if l == " ":
			if iteration == 0:
				command = token
			else:
				args = token
			iteration += 1
			token = ""
		elif charCount == input_text.length():
			token += l
			if iteration == 0:
				command = token
			else:
				args = token
			token = ""
		else:
			token += l
		charCount += 1
	print(command)
	print(args)
	
	match command:
		"encounter":
			if args.empty():
				Functions.encounter_random_monster()
			else:
				for mon in Functions.monsters:
					if(mon["species"] == args):
						Functions.encounter_random_monster(mon)
		"forcecatch":
			Functions.get_new_monster()
		"":
			pass
	self.clear()
