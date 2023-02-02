extends Area2D


var spawnChance = float(1)/20 * 100


# Called when the node enters the scene tree for the first time.
func _ready():
	print(spawnChance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EncounterArea_mouse_entered():
	randomize()
	var randomChance = randi()%int(spawnChance) + 1
	if randomChance == spawnChance:
		Functions.encounter_random_monster()
