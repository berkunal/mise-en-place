extends Area2D

@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.animation = "run"
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.animation = "run"
		velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "idle"

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
	var cam_pos: Vector2 = $Camera2D.global_position

	position += velocity * delta
	position.x = clamp(position.x, $Camera2D.limit_left, $Camera2D.limit_right)
