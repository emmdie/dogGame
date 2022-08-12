extends Area2D

signal hit
signal collected

export var speed = 400
var screen_size
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _process(delta):
	var velocity = Vector2.ZERO #the players movement vector
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.y = clamp(position.y, 0, screen_size.y)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Mafi_body_entered(body):
	print("entered")
	if (body.get_name() == "Stone"):
		print("stone")
		hide()
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		print("not stone")
		emit_signal("collected")
		body.queue_free()
