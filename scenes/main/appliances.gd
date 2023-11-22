extends Node2D

signal upgrade_requested(appliance)

var is_user_collides_with_appliance = false
var collided_appliance: Area2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_user_collides_with_appliance:
		if Input.is_action_just_pressed("take_action"):
			upgrade_requested.emit(collided_appliance)

func _on_player_area_entered(area: Area2D):
	is_user_collides_with_appliance = true
	collided_appliance = area

	var coinsNode = area.get_node("Coins")
	for coin in coinsNode.get_children():
		if coin.is_class('Sprite2D'):
			(coin as Sprite2D).visible = true

func _on_player_area_exited(area: Area2D):
	is_user_collides_with_appliance = false
	collided_appliance = null
	
	var coinsNode = area.get_node("Coins")
	for coin in coinsNode.get_children():
		if coin.is_class('Sprite2D'):
			(coin as Sprite2D).visible = false
