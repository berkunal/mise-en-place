extends Node2D

signal upgrade_purchased(required_coin)

@export var coin_needed_for_build: int = 3

var user_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: instead of manual PathFollow2D, create a curve programmatically
	$Coins/Path2D/PathFollow2D.progress_ratio = 0
	for i in range(0, coin_needed_for_build):
		var coinScene = preload("res://components/coin/coin.tscn").instantiate() as Sprite2D
		coinScene.position = $Coins/Path2D/PathFollow2D.position
		coinScene.visible = false
		$Coins.add_child(coinScene)

		$Coins/Path2D/PathFollow2D.progress_ratio += 1.0 / (coin_needed_for_build - 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if user_inside:
		if Input.is_action_just_pressed("take_action") and coin_needed_for_build > 0:
			upgrade_purchased.emit(coin_needed_for_build)

func _on_player_area_entered(_area):
	user_inside = true

	for coin in $Coins.get_children():
		if coin.is_class('Sprite2D'):
			(coin as Sprite2D).visible = true


func _on_player_area_exited(_area):
	user_inside = false

	for coin in $Coins.get_children():
		if coin.is_class('Sprite2D'):
			(coin as Sprite2D).visible = false

func upgrade():
	coin_needed_for_build = -1
	$TempLabel.visible = true
	
	for coin in $Coins.get_children():
		if coin.is_class('Sprite2D'):
			coin.free()
