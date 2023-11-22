extends Node2D

@export var coin_needed_for_build: int = 3

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


func upgrade():
	coin_needed_for_build = -1
	$TempLabel.visible = true
	
	for coin in $Coins.get_children():
		if coin.is_class('Sprite2D'):
			coin.free()
