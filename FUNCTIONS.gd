extends Node2D

var monsterRes = preload("res://Monster.tscn")

var monsters = [
	{"species": "Choupignon", "type": 9, "catch_rate": 255, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[1,8]},
	{"species": "Grognongnon", "type": 2, "catch_rate": 100, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[5,3]},
	{"species": "Libebulle", "type": 1, "catch_rate": 255, "base_atk": 40, "base_def": 30, "base_speed": 40, "movepool":[3,7]},
	{"species": "Petitronc", "type": 9, "catch_rate": 80, "base_atk": 90, "base_def": 20, "base_speed": 40, "movepool":[1,2,7]},
	{"species": "Chatignon", "type": 0, "catch_rate": 150, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[1,3,8,7]},
	{"species": "Froussaille", "type": 7, "catch_rate": 170, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[15,12,1]},
	{"species": "Mirowatt", "type": 3, "catch_rate": 200, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[6,11]},
	{"species": "Mirovolt", "type": 3, "catch_rate": 150, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[6,11]},
	{"species": "Mirampère", "type": 3, "catch_rate": 100, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[6,11]},
	{"species": "Calkeau", "type": 1, "catch_rate": 200, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[16,17]},
	{"species": "Balocendre", "type": 2, "catch_rate": 140, "base_atk": 40, "base_def": 20, "base_speed": 40, "movepool":[5,7,18,19]}
]

var moves = [
	{"id": 1, "name": "Estangriffe", "type": 0, "damage": 100},
	{"id": 2,"name": "Divitronc", "type": 9, "damage": 150},
	{"id": 3,"name": "Infencri", "type": 0, "damage": 40},
	{"id": 4,"name": "Cri'O-genie", "type": 4, "damage": 100},
	{"id": 5,"name": "Feumigène", "type": 2, "damage": 40},
	{"id": 6,"name": "Para-digme", "type": 3, "damage": 0},
	{"id": 7,"name": "Sigmatisation", "type": 0, "damage": 100},
	{"id": 8,"name": "Uppercoupe", "type": 8, "damage": 70},
	{"id": 9,"name": "Glace-chant", "type": 4, "damage": 20},
	{"id": 10,"name": "Virus Lent", "type": 10, "damage": 40},
	{"id": 11,"name": "Foudrogifles", "type": 3, "damage": 80},
	{"id": 12,"name": "Nébubulles", "type": 7, "damage": 40},
	{"id": 13,"name": "Fanto'stique", "type": 7, "damage": 0},
	{"id": 14,"name": "Lumière mystique", "type": 6, "damage": 100},
	{"id": 15,"name": "Polymorphe", "type": 0, "damage": 0}, #prend le type de l'adversaire pendant quelques tours
	{"id": 16,"name": "Pog'o", "type": 1, "damage": 80},
	{"id": 17,"name": "Liquidation", "type": 1, "damage": 120},
	{"id": 18,"name": "Signal de feu", "type": 2, "damage": 0}, #switch et si pkmn a atk feu il a un boost
	{"id": 19,"name": "Four-tout", "type": 2, "damage": 100},
	{"id": 20,"name": "Givré", "type": 4, "damage": 0}, #le pkmn a plus de chance de louper l'attaque mais il devient cheat sa mere
	{"id": 21,"name": "Verglagla", "type": 4, "damage": 0}, #transforme le terrain en glace (- vitesse pour pkmn non glace)
	{"id": 22,"name": "Perfore-glace", "type": 4, "damage": 90},
	{"id": 23,"name": "Problème technique", "type": 3, "damage": 100},
	{"id": 24,"name": "Obscurité éternelle", "type": 5, "damage": 100}, #baisse la précision de tous les monstre non spectre
	{"id": 24,"name": "Absorption galactique", "type": 6, "damage": 150},
	
	
]

var types = [
	{"id": 0, "name": "Normal", "strong_against": [], "resist_against": []},
	{"id": 1, "name": "Water", "strong_against": [], "resist_against": [2]},
	{"id": 2, "name": "Fire", "strong_against": [9,4], "resist_against": [9]},
	{"id": 3, "name": "Volt", "strong_against": [1], "resist_against": []},
	{"id": 4, "name": "Ice", "strong_against": [], "resist_against": []},
	{"id": 5, "name": "Dark", "strong_against": [], "resist_against": []},
	{"id": 6, "name": "Psychic", "strong_against": [], "resist_against": []},
	{"id": 7, "name": "Ghost", "strong_against": [], "resist_against": []},
	{"id": 8, "name": "Fighting", "strong_against": [], "resist_against": []},
	{"id": 9, "name": "Grass", "strong_against": [1], "resist_against": [1]},
	{"id": 10, "name": "Poison", "strong_against": [], "resist_against": []}
]

onready var debug_controls = get_tree().get_root().get_node("/root/Game/debug_controls")
#var debug_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	#debug
	print('deb')
#	debug_instance = debug_controls.instance()
#	get_tree().get_root().get_node('Game').add_child(debug_instance)


func encounter_random_monster(monster = ""):
	var randomMon
	if monster.empty():
		randomize()
		randomMon = monsters[randi() % monsters.size()]
	else:
		randomMon = monster
	instantiate_monster(randomMon)
#	debug_instance.visible = true
	debug_controls.get_node('VBoxContainer/debug_catch').visible = true
	player_send_monster()

func player_send_monster():
	print('sending player monster')
	print(Data.monsters[0])
	instantiate_monster(Data.monsters[0], false)
	
func instantiate_monster(monster, opponent = true):
	var newMonster = monsterRes.instance()
	newMonster.init(monster, opponent)
	get_tree().get_root().get_node('Game').add_child(newMonster)
	
func try_catch(ball):
	var ballChance = 1
	match ball:
		"normal":
			ballChance = 1
		"super":
			ballChance = 1.5
		"hyper":
			ballChance = 2
		"master":
			ballChance = 255
	print("trying to catch...")
	randomize()
	var catchChance = randi()%255+1
	var catchRate = ((3*Globals.opponent.maxhp - 2 * Globals.opponent.hp) * (Globals.opponent.catch_rate * ballChance) / (3 * Globals.opponent.maxhp))
	print('new catch rate = ' + str(catchRate))
	print('your chance is ' + str(catchChance))
	
#	Catch Rate = ((3 * Max HP - 2 * Current HP) * (Catch Rate * Ball Modifier) / (3 * Max HP)) * Status Modifier
#Once the catch rate has been calculated, the game will generate a random number between 0 and 1. If this number is less than or equal to the catch rate, the Pokémon will be caught. 
	if catchChance <= catchRate :
		print('caught sucessfully')
		get_new_monster()
		Functions.end_battle()
	else:
		print('catch failed')

func get_new_monster(monster = Globals.opponent):
	var new_monster = {
		"species": monster.species,
		"level": monster.level,
		"atk": monster.atk,
		"def": monster.def,
		"speed": monster.speed,
		"hp": monster.hp,
		"maxhp": monster.maxhp,
		"type": monster.type,
		"moves": monster.moves
	}
	Data.monsters.append(new_monster)
	print('Monster added to monster list')
	Data.save_file()

func end_battle():
	Globals.opponent.queue_free()
	Globals.player_monster.queue_free()
	Globals.opponent = null
	Globals.player_monster = null
	Globals.battle_hud = null
	print('battle end')
	
#	DEBUG
	Data.save_file()
	
func attack(move, from_player):
	var attacker
	var receiver
	if from_player == true:
		attacker = Globals.player_monster
		receiver = Globals.opponent
	else:
		attacker = Globals.opponent
		receiver = Globals.player_monster
		
	Globals.battle_hud.display_text(str(attacker.species) + " attaque " + str(receiver.species) + " avec " + move.name + " !")
		
	print('reciever is___')
	print(receiver)
	var move_dmg = move.damage
	var move_type = Functions.types[move.type]
	var type_multiplier = 1.0
	
	var receiver_type = receiver.type
#	Check strenghts
	for type in move_type.strong_against:
		if type == receiver_type:
			type_multiplier *= 2
#	Check resistances
	for type in Functions.types[receiver_type].resist_against:
		if type == move_type.id:
			type_multiplier = type_multiplier / 2
			
	print('type mult is ' + str(type_multiplier))
	var stats_dif = attacker.atk - receiver.def
	if stats_dif < 0:
		stats_dif = 0
	receiver.damage(move_dmg * type_multiplier + stats_dif)
	
#	debug enemy attack
	if from_player:
#		wait a second (debug)
		var time_in_seconds = 3
		yield(get_tree().create_timer(time_in_seconds), "timeout")
		if Globals.opponent != null:
			var randomMove = Globals.opponent.moves[randi() % Globals.opponent.moves.size()]
			print("move__enemy")
			print(Functions.moves[randomMove])
			attack(Functions.moves[randomMove-1], false)
