extends Node


var player_name
var play_time
var monsters

func _ready():
	print('data ready')
	load_file()

func save_file():
	var file = File.new()
	var save_struct = {
		"save1":{
			"savename": player_name,
			"play_time": play_time,
			"monsters": monsters
		}
	}
	file.open("user://save.txt", File.WRITE)
	file.store_string(JSON.print(save_struct))
	file.close()
	print('saved')
	


func load_file(fileID = "save1"):
	var file = File.new()
	file.open("user://save.txt", File.READ)
	var save_data = parse_json(file.get_as_text())[fileID]
	player_name = save_data.savename
	play_time = save_data.play_time
	monsters = save_data.monsters
	file.close()
	print('loaded')
	print('player name : ' + player_name)
	print('play time : ' + str(play_time))
	print('monsters : ' + str(monsters))
