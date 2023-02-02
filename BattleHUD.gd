extends Control

var moves = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.battle_hud = $Battle_Text
	
	for move in Globals.player_monster.moves:
		var move_f = Functions.moves[move-1]
		moves.append(move_f)
		$Moves.add_item(str(move_f['name']) + " - " + str(move_f['damage']) + " [" + str(Functions.types[move_f['type']].name) + "]")
	$Moves.show()

func _on_Moves_index_pressed(index):
	var move = moves[index]
	print("move__me")
	print(move)
	Functions.attack(move, true)
	
