extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_debug_catch_pressed():
	Functions.try_catch("hyper")


func _on_debug_encounter_pressed():
	Functions.encounter_random_monster()


func _on_debug_damage_pressed():
	Globals.opponent.damage(Globals.player_monster.atk)
