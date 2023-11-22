extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_camera_limits()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Sets the player's camera limits to prevent scrolling too much
func set_camera_limits():
	# We need the width of the current background and the position of it
	var width: float = get_bg_width()
	var pos: Vector2 = $BackgroundBasic.position
	
	$Player/Camera2D.limit_left = pos.x - width/2
	$Player/Camera2D.limit_right = pos.x + width/2

# Calculates the background width by multiplying the Scale and Size vectors
func get_bg_width():
	var bgTransform: Transform2D = $BackgroundBasic.transform
	var bgScaleVector: Vector2 = bgTransform.get_scale()

	var bgTexture: Texture2D = $BackgroundBasic.texture
	var bgTextureSize: Vector2 = bgTexture.get_size()

	var currentSize: Vector2 = bgScaleVector * bgTextureSize
	return currentSize.x


func _on_appliances_upgrade_requested(appliance):
	if appliance.coin_needed_for_build > $GUI/Currency.current_money:
		printerr("not enough eggs")
		return

	$GUI/Currency.increment_money_by_value(-appliance.coin_needed_for_build)
	appliance.upgrade()
