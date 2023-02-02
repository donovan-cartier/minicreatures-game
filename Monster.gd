extends Node2D

var species
var level
var type
var type_str
var atk
var def
var speed
var hp
var maxhp
var catch_rate
var moves = []
var is_opponent

var hpStored
var damageAmount
onready var hp_timer = $HPTimer
var battleHUD = load("res://BattleHUD.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	hp_timer.connect("timeout", self, "_decrease_hp")
	
	if is_opponent:
		global_position.x = get_viewport_rect().size.x / 2
		global_position.y = get_viewport_rect().size.y / 2
	else:
		global_position.x = get_viewport_rect().size.x /3
		global_position.y = get_viewport_rect().size.y / 1.5
		var battleHUD_I = battleHUD.instance()
		get_tree().get_root().get_node("Game").add_child(battleHUD_I)

func init(monster, opponent = true):
	is_opponent = opponent
	species = monster.species
	type = monster.type
	type_str = Functions.types[type].name
	var baseHP = 12 #debug for mpnster base hp

	
	if is_opponent:
		catch_rate = monster.catch_rate
		level = randi()%100+1
#		level = 1
		atk = monster.base_atk + (level * 2)
		speed = monster.base_speed + (level * 2)
		def = monster.base_def + (level * 2)
		hp = floor(baseHP + (level*3))
		maxhp = hp
#		For now, give every move of movepool
		moves = monster.movepool
	else:
		atk = monster.atk
		speed = monster.atk
		def = monster.atk
		level = monster.level
		hp = monster.hp
		maxhp = monster.maxhp
		moves = monster.moves

	print("Un " + species + " sauvage apparaît !")
	print("Nv :" + str(level))
	print("Type :" + type_str)
	

	print ("HP : " + str(hp))
	
	var spriteRes
	
	if opponent:
		Globals.opponent = self
		var spritePath = "res://Sprites/Monsters/frontsprites/" + str(species).to_lower() + ".png"
		spriteRes = load(spritePath) 
		if spriteRes == null:
			spriteRes = load("res://Sprites/Monsters/frontsprites/front.png")
	else:
		Globals.player_monster = self
		spriteRes = load("res://Sprites/Monsters/backsprites/back.png")
		
	$Sprite.texture = spriteRes
	update_hud()



func damage(amt):
#	hp -= amt
	hpStored = hp
	damageAmount = amt
	print("damage amt: " + str(damageAmount))
	print("decrease amt: " + str(hpStored-damageAmount))
#	$HPTimer.start()
	_decrease_hp()
#	while(hp > hpBefore-amt):
#		print('it')
#		hp -= 1
#		$HPBar.value = hp
#
#	if hp <= 0:
#		hp = 0
#		print('monster died')
#		Functions.end_battle()
#	else:
#		hp_timer.start(1)
#	update_hud()


func _decrease_hp():
	hp -= 1
	update_hud()
	if(hp > hpStored-damageAmount):
#		$HPTimer.start()
		yield(get_tree(), "idle_frame")
		_decrease_hp()
		if(hp <= 0):
#			$HPTimer.stop()
			hp = 0
			print('monster died')
			Functions.end_battle()

	
func update_hud():
	$HP.text = str(hp) + "/" + str(maxhp) + " PV"
	$HPBar.max_value = maxhp
	$HPBar.value = hp
	$Name.text = species
	$Level.text = "lvl." + str(level)
	$Type.text = type_str


